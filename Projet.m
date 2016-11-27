close all;

load('sauvegarde.mat')

%Cr�er le fichier video 
resultat_video=VideoWriter('resultat_video.avi');
open(resultat_video);


%Importer la vid�o et l'image � ins�rer
video_init=VideoReader('vid_in.mp4');
image1 = imread('trombinoscope.jpg');

%Choix du seuil
seuil=70;

%intialisationn (premiere image)

 X=[1.891807909604520e+02 3.864869109947644e+02 3.801320754716981e+02 1.758205128205128e+02];
 Y=[1.479717514124294e+02 1.531361256544503e+02 2.970943396226415e+02 2.884410256410257e+02];
 [dimY,dimX,~]=size(image0);
 mask=zeros([dimY,dimX]);
 MatBary=[X;Y];
 

 Incrus=motif2frame(image1,image0,MatBary(1,:),MatBary(2,:),1/1.2,mask);

 writeVideo(resultat_video,Incrus);
 
 OldBary=MatBary;
 
 %Toutes les images
 %------------------
 
 for i=2:video_init.NumberOfFrames
     
    % charge l'immage
    image = read(video_init,i);
 
    %Calcul des distances de Maha
    distMaha = Distance_Maha(image, invCov, u);   
          
    % seuil
    ImageMaha=distMaha<seuil;

    % nettoyer dilate erode
    Image_nettoyee = Nettoyage(ImageMaha);
    
    
    %Labelisation
    L = bwlabel(Image_nettoyee);

     
     % Calculer barycentre
     %Detection des Barycentres
               
     Matrice_Barycentre = Detection_barycentre(L);
     
     % ordonner les barycentres
     
     Position_Bary = Ordonner_barycentre(OldBary, Matrice_Barycentre);
     
     % incruster l'image

      Incrus=motif2frame(image1,image,Position_Bary(1,:),Position_Bary(2,:),1/1.2,mask);
      
      % ecrire dans la video
      writeVideo(resultat_video,Incrus);
      
      OldBary = Position_Bary;
       
 end
 

close(resultat_video);

