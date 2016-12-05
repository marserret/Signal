function [DistMaha] = Distance_Maha( img,matCov, moy )


imgR=double(img(:,:,1));
imgV=double(img(:,:,2));
imgB=double(img(:,:,3));

%creation de la matrice des xi- moyenne , avec tous les pixels en une suele fois
lineR=reshape(imgR,1,numel(imgR));
lineV=reshape(imgV,1,numel(imgV));
lineB=reshape(imgB,1,numel(imgB));
lineR=lineR-moy(1);
lineV=lineV-moy(2);
lineB=lineB-moy(3);
Vectmaha=[lineR;lineV;lineB];


W= matCov * Vectmaha;
DistMaha= Vectmaha .* W;

DistMaha = sum(DistMaha,1);

%Création de l'image avec les distances
DistMaha= reshape( DistMaha, [size(img,1),size(img,2)]);
end