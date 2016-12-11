function [Image_nettoyee] = Nettoyage(Image_Maha)
%Focntion permettant de supprimer les points isolés (infèrieurs à un cercle
%de rayon défini)

se=strel('disk',5);
Image_nettoyee = imerode(Image_Maha, se);
Image_nettoyee = imdilate(Image_nettoyee,se);
Image_nettoyee = Image_nettoyee.*255;

end