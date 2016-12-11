close all;

load('sauvegarde.mat')

%Cr�er le fichier video 
resultat_video = VideoWriter('resultat_video.avi');
open(resultat_video);

%Importer la vid�o initiale et la vid�o � ins�rer
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
 
 %Cr�ation du Mask
 [dimY,dimX,~]=size(image0);
 mask=zeros([dimY,dimX]);
 
 %Incrustation de la premi�re image de la vid�o � incruster dans la vid�o
 %initiale
 Incrus=motif2frame(image_jordan,image0,MatBary(1,:),MatBary(2,:),1/1.2,mask);
 
 writeVideo(resultat_video,Incrus);
 
 OldBary=MatBary;

 
 %------------------------------------------------
 %Seconde partie : application � toutes les images
 %------------------------------------------------

 for i=2:video_init.NumberOfFrames
     
    %Chargement des images
    image = read(video_init,i);
    image_jordan = read(video_jordan, i);
 
    %Calcul des distances de Maha
    distMaha = Distance_Maha(image, invCov, u);   

    %Trie de l'image par un seuil 
    ImageMaha = distMaha<seuil;  

    %Nettoyage des points isol�s (nettoyer dilate erode)
    Image_nettoyee = Nettoyage(ImageMaha);

    %Labelisation
    L = bwlabel(Image_nettoyee);
    

    %Calculer barycentre
    %Detection des Barycentres
               
     Matrice_Barycentre = Detection_barycentre(L);
     
    %Ordonner les barycentres
     
     Position_Bary = Ordonner_barycentre(OldBary, Matrice_Barycentre);
     
    %M�me op�ration pour les doigts avec et sans ombre
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

