close all;

load('sauvegarde.mat')

%Créer le fichier video 
resultat_video=VideoWriter( 'resultat_video.avi');
open(resultat_video);


%Importer la vidéo et l'image à insérer
video_init=VideoReader('vid_in.mp4');
image1 = imread('trombinoscope.jpg');

%Choix du seuil
seuil=50;

%intialisationn (premiere image)

 X=[1.891807909604520e+02 3.864869109947644e+02 3.801320754716981e+02 1.758205128205128e+02];
 Y=[1.479717514124294e+02 1.531361256544503e+02 2.970943396226415e+02 2.884410256410257e+02];
 [dimY,dimX,~]=size(image0);
 mask=zeros([dimY,dimX]);
 MatBary=[X;Y];
 

 Incrus=motif2frame(image1,image0,MatBary(1,:),MatBary(2,:),1/1.2,mask);
 imshow(Incrus);
 writeVideo(resultat_video,Incrus);
 
 OldBary=MatBary;
 
 %Toutes les images
 %------------------
 
 for i=2:10
     
    % charge l'immage
    image = read(video0,i);
 
    %Calcul des distances de Maha
    distMaha = Distance_Maha(image0, matCov, u);    
      
    % seuil
    ImageMaha=distMaha<seuil;

    % nettoyer dilate erode
     
     
    %Labelisation
    L = Labelisation(ImageMaha);

     
     % Calculer barycentre
     %Detection des Barycentres
        nbBar=4;
        NewBarycentres=zeros(nbBar,2);
        
        Matrice_Barycentre = Detection_barycentre(L, NewBarycentres);
     
     % ordonner les barycentres
     
     Position_Bary = Ordonner_barycentre(OldBary, Matrice_Barycentre);
     
     % incruster l'image

      Incrus=motif2frame(image1,image0,Position_Bary(1,:),Position_Bary(2,:),1/1.2,mask);
      
      % ecrire dans la video
      writeVideo(resulta_video,Incrus);
      
      OldBary = Position_Bary;
       
 end
 

close(resultat_video);

