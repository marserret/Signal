function [Image_nettoyee] = Nettoyage(Image_Maha)

se=strel('disk',5);
Image_nettoyee= imerode(Image_Maha, se);
Image_nettoyee=imdilate(Image_nettoyee,se);
Image_nettoyee=Image_nettoyee.*255;

end