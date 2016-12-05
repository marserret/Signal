close all;
clear all;

%Importer la vidéo
video0 = VideoReader('vid_in.mp4');

%Extraire image
image0 = read(video0, 1);
imshow(image0);

%Selectionner un rectangle dans une des pastilles bleues foncées et l'afficher

image1=Selection_zone(image0);

%Covariance
[matCov, u] = Covariance(image1);
invCov = inv(matCov);

%Calcul des distances de Maha
distMaha = Distance_Maha(image0, invCov, u);
figure,imagesc(distMaha);

%---------------------------------
%---------------------------------

%Extraire image doigts
image_doigts = read(video0, 38);
imshow(image_doigts);

%Selectionner un rectangle des doigts et l'afficher
image_doigts_selectionnes=Selection_zone(image_doigts);

%Covariance doigts
[matCov_doigts, u_doigts] = Covariance(image_doigts_selectionnes);
invCov_doigts = inv(matCov_doigts);

%Calcul des distances de Maha
distMaha_doigts = Distance_Maha(image_doigts, invCov_doigts, u_doigts);
figure,imagesc(distMaha_doigts);

save('sauvegarde','matCov','u','distMaha', 'image0', 'invCov', 'matCov_doigts', 'u_doigts', 'distMaha_doigts', 'image_doigts', 'invCov_doigts');


