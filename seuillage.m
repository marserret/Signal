function Seuil = seuillage(ImageMaha)

seuil=50;

for i=1:size(distMaha,1)
    for j=1:size(distMaha,2)
        if distMaha(i,j) > seuil
            ImageMaha(i,j)=0;
        else ImageMaha(i,j)=1;
        end
    end
end

Seuil = ImageMaha;