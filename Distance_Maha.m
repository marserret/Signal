function [Distance_Maha] = Distance_Maha( imgage,matCov, moyenne)
%fonction permettant de créer les distance de mahalanobis

ComposanteR=double(imgage(:,:,1));
ComposanteV=double(imgage(:,:,2));
ComposanteB=double(imgage(:,:,3));

%A partir de tous les pixels, creation de la matrice des xi- moyenne.
lineR=reshape(ComposanteR,1,numel(ComposanteR));
lineV=reshape(ComposanteV,1,numel(ComposanteV));
lineB=reshape(ComposanteB,1,numel(ComposanteB));
lineR=lineR-moyenne(1);
lineV=lineV-moyenne(2);
lineB=lineB-moyenne(3);

Vecteur_maha=[lineR;lineV;lineB];


W= matCov * Vecteur_maha;
Distance_Maha= Vecteur_maha .* W;

Distance_Maha = sum(Distance_Maha,1);

%Création de l'image avec les distances
Distance_Maha = reshape(Distance_Maha, [size(img,1),size(img,2)]);
end