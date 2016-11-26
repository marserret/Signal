close all;
clear all;
%Importer la vidéo
video0 = VideoReader('vid_in.mp4');


%Extraire image
image0 = read(video0, 1);
imshow(image0)


%Selectionner un rectangle bleu foncé et l'afficher
[x,y] = ginput(2);
image1=image0(min(y):max(y),min(x):max(x),:);
imshow(image1)


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


matCov=[cov11 cov12 cov13;cov21 cov22 cov23;cov31 cov32 cov33];




%Calcul des distances de Maha
distMaha= zeros(size(image0,1),size(image0,2));
for i=1:size(image0,1)
    for j=1:size(image0,2)
        xi=[image0(i,j,1),image0(i,j,2),image0(i,j,3)];
        distMaha(i,j)=(double(xi)-u)*(matCov^-1)*(double(xi)-u).';
    end
end
figure,imagesc(distMaha)


save('sauvegarde','matCov','u','distMaha', 'image0');


