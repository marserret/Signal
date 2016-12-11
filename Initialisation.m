close all;
clear all;

%Importer la vidéo
video0 = VideoReader('vid_in.mp4');

%-------------------
%Etude des pastilles
%-------------------

%Extraire image
image0 = read(video0, 1);
imshow(image0);

%Selectionner un rectangle dans une des pastilles bleues foncées et l'afficher
image1=Selection_zone(image0);

%Covariance
[matCov, u] = Covariance(image1);
invCov = inv(matCov); %Inversion de la matrice de covariance

%Calcul des distances de Mahalanobis 
distMaha = Distance_Maha(image0, invCov, u);
figure,imagesc(distMaha);
title('Distance de Mahalanobis des 4 picots');

%---------------------------------
%Etude des doigts
%---------------------------------

%Même principe que pour les pastilles

%Extraire image doigts
image_doigts = read(video0, 70);

%Selection automatique des doigts
image_doigts_selectionnes = image_doigts(183:196,309:323,:);

%Covariance doigts
[matCov_doigts, u_doigts] = Covariance(image_doigts_selectionnes);
invCov_doigts = inv(matCov_doigts);

%Calcul des distances de Maha
distMaha_doigts = Distance_Maha(image_doigts, invCov_doigts, u_doigts);
figure,imagesc(distMaha_doigts);
title('Distance de Mahalanobis des doigts');

%---------------------------------
%Etude des doigts lors de la rotation de la main et de l'apparition d'une
%ombre
%---------------------------------
%Extraire image doigts
image_doigts_sombre = read(video0, 150);

%Selection automatique des doigts
image_doigts_sombre_selectionnes=image_doigts_sombre(247:259,218:223,:);

%Covariance doigts
[matCov_doigts_sombre, u_doigts_sombre] = Covariance(image_doigts_sombre_selectionnes);
invCov_doigts_sombre = inv(matCov_doigts_sombre);

%Calcul des distances de Maha
distMaha_doigts_sombre = Distance_Maha(image_doigts_sombre, invCov_doigts_sombre, u_doigts_sombre);
figure,imagesc(distMaha_doigts_sombre);
title('Distance de Mahalanobis des doigts avec l ombre');


save('sauvegarde','matCov','u','distMaha', 'image0', 'invCov', 'matCov_doigts', 'u_doigts', 'distMaha_doigts', 'image_doigts', 'invCov_doigts', 'matCov_doigts_sombre', 'u_doigts_sombre', 'distMaha_doigts_sombre', 'image_doigts_sombre');


