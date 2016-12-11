close all;

load('sauvegarde.mat')

%Créer le fichier video 
resultat_video = VideoWriter('resultat_video.avi');
open(resultat_video);

%Importer la vidéo initiale et la vidéo à insérer
video_init=VideoReader('vid_in.mp4');

video_jordan = VideoReader('Jordan.mp4');
image_jordan = read(video_jordan, 1);

%Choix du seuil pour les pastilles 
seuil=80;

%------------------------------
%intialisationn (premiere image)
%------------------------------

 X=[1.891807909604520e+02 3.864869109947644e+02 3.801320754716981e+02 1.758205128205128e+02];
 Y=[1.479717514124294e+02 1.531361256544503e+02 2.970943396226415e+02 2.884410256410257e+02];

 MatBary=[X;Y];
 
 %Création du Mask
 [dimY,dimX,~]=size(image0);
 mask=zeros([dimY,dimX]);
 
 %Incrustation de la première image de la vidéo à incruster dans la vidéo
 %initiale
 Incrus=motif2frame(image_jordan,image0,MatBary(1,:),MatBary(2,:),1/1.2,mask);
 
 writeVideo(resultat_video,Incrus);
 
 OldBary=MatBary;

 
 %------------------------------------------------
 %Seconde partie : application à toutes les images
 %------------------------------------------------

 for i=2:video_init.NumberOfFrames
     
    %Chargement des images
    image = read(video_init,i);
    image_jordan = read(video_jordan, i);
 
    %Calcul des distances de Maha
    distMaha = Distance_Maha(image, invCov, u);   

    %Trie de l'image par un seuil 
    ImageMaha = distMaha<seuil;  

    %Nettoyage des points isolés (nettoyer dilate erode)
    Image_nettoyee = Nettoyage(ImageMaha);

    %Labelisation
    L = bwlabel(Image_nettoyee);
    

    %Calculer barycentre
    %Detection des Barycentres
               
     Matrice_Barycentre = Detection_barycentre(L);
     
    %Ordonner les barycentres
     
     Position_Bary = Ordonner_barycentre(OldBary, Matrice_Barycentre);
     
    %Même opération pour les doigts avec et sans ombre
     if ((i<115) || (i>200))
         seuil_doigts = 32;
         distMaha_doigts = Distance_Maha(image, invCov_doigts, u_doigts);
         ImageMaha_doigts = distMaha_doigts<seuil_doigts;
         mask = ImageMaha_doigts;
     
     else
         seuil_doigts = 285;
         distMaha_doigts = Distance_Maha(image, invCov_doigts_sombre, u_doigts_sombre);
         ImageMaha_doigts = distMaha_doigts<seuil_doigts;
         mask = ImageMaha_doigts;
     end
     
    %Incruster l'image
     
     Incrus=motif2frame(image_jordan,image,Position_Bary(1,:),Position_Bary(2,:),1/1.2,mask);
      
     %Ecrire dans la video
      writeVideo(resultat_video,Incrus);
      
      OldBary = Position_Bary;
 end
 
close(resultat_video);

