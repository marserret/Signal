function [Matrice_covariance, u] = Covariance(image)
%Fonction permettant de calculer le vecteur moyenne ainsi que la matrice de
%covariance

%Calcul des moyennes
%Selection de toutes les composantes d'une couleur de la région d'intérêt
R0=double(image(:,:,1));
G0=double(image(:,:,2));
B0=double(image(:,:,3));

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

Matrice_covariance=[cov11 cov12 cov13; cov21 cov22 cov23; cov31 cov32 cov33];

end