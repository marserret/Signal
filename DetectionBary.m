function Barycentre = DetectionBary(Img, nb)
    [nbPixelsColonne,nbPixelsLigne]=size(Img);
    ImageBinaire=zeros(nbPixelsColonne,nbPixelsLigne);
    
    for i=1:nbPixelsColonne
        for j=1:nbPixelsLigne
            if(Img(i,j)==nb)
                ImageBinaire(i,j)=1;
            end
        end
    end
    [X,Y]=find(ImageBinaire);
    x=mean(X);
    y=mean(Y);
    Barycentre=[x,y];
        
end


