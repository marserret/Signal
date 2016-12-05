close all;
clear all;

%Importer la vidéo
video0 = VideoReader('vid_in.mp4');

%Extraire image
image0 = read(video0, 1);
imshow(image0);

%Selectionner un rectangle dans une des pastilles bleues foncées et l'afficher

image1=Selection_zone(image0);

%Calcul du nombre d'éléments de l'échantillon
N=size(image1,1)*size(image1,2);

%Calcul des moyennes
%Selection de toutes les composantes d'une couleur de la région d'intérêt
R0=double(image1(:,:,1));
G0=double(image1(:,:,2));
B0=double(image1(:,:,3));


R1=R0(:);
G1=G0(:);
B1=B0(:);


%Calcul de la moyenne de chaque composante
moyenneR1=mean(R1);
moyenneG1=mean(G1);
moyenneB1=mean(B1);


%Vecteur des moyennes
u=[moyenneR1,moyenneG1,moyenneB1];


%Calcul des covariances
%Calcul des termes de la matrice de covariance


RR=(R1-moyenneR1);
BB=(B1-moyenneB1);
GG=(G1-moyenneG1);

cov11=mean(RR.*RR);
cov22=mean(GG.*GG);
cov33=mean(BB.*BB);
cov12=mean(RR.*GG);
cov21=cov12;
cov23=mean(GG.*BB);
cov32=cov23;
cov13=mean(RR.*BB);
cov31=cov13;


%Création de la matrice de covariances

matCov=[cov11 cov12 cov13; cov21 cov22 cov23; cov31 cov32 cov33];
invCov=inv(matCov);

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

%Calcul du nombre d'éléments de l'échantillon
N_doigts=size(image_doigts_selectionnes,1)*size(image_doigts_selectionnes,2);

%Calcul des moyennes sur les doigts
%Selection de toutes les composantes d'une couleur de la région d'intérêt des doigts
R0_doigts=double(image_doigts_selectionnes(:,:,1));
G0_doigts=double(image_doigts_selectionnes(:,:,2));
B0_doigts=double(image_doigts_selectionnes(:,:,3));


R1_doigts=R0_doigts(:);
G1_doigts=G0_doigts(:);
B1_doigts=B0_doigts(:);


%Calcul de la moyenne de chaque composante des doigts
moyenneR1_doigts=mean(R1_doigts);
moyenneG1_doigts=mean(G1_doigts);
moyenneB1_doigts=mean(B1_doigts);

%Vecteur des moyennes sur les doigts
u_doigts=[moyenneR1_doigts,moyenneG1_doigts,moyenneB1_doigts];


%Calcul des covariances sur les doigts
%Calcul des termes de la matrice de covariance sur les doigts


RR_doigts=(R1_doigts-moyenneR1_doigts);
BB_doigts=(B1_doigts-moyenneB1_doigts);
GG_doigts=(G1_doigts-moyenneG1_doigts);

cov11_doigts=mean(RR_doigts.*RR_doigts);
cov22_doigts=mean(GG_doigts.*GG_doigts);
cov33_doigts=mean(BB_doigts.*BB_doigts);
cov12_doigts=mean(RR_doigts.*GG_doigts);
cov21_doigts=cov12_doigts;
cov23_doigts=mean(GG_doigts.*BB_doigts);
cov32_doigts=cov23_doigts;
cov13_doigts=mean(RR_doigts.*BB_doigts);
cov31_doigts=cov13_doigts;


%Création de la matrice de covariances

matCov_doigts=[cov11_doigts cov12_doigts cov13_doigts; cov21_doigts cov22_doigts cov23_doigts; cov31_doigts cov32_doigts cov33_doigts];
invCov_doigts=inv(matCov_doigts);

%Calcul des distances de Maha
distMaha_doigts = Distance_Maha(image_doigts, invCov_doigts, u_doigts);
figure,imagesc(distMaha_doigts);

save('sauvegarde','matCov','u','distMaha', 'image0', 'invCov', 'matCov_doigts', 'u_doigts', 'distMaha_doigts', 'image_doigts', 'invCov_doigts');


