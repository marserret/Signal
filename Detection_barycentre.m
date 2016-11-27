function [Detection] = Detection_barycentre(L)

nbBar=4;
Detection=zeros(2,nbBar);

for i=1:4 %On range les coordonnées des barycentres dans une matrice 2*4
            %B=DetectionBary(L,i);

            [y,x]=find(L == i);
                
            Detection(1,i)= mean(double(x));
            Detection(2,i)= mean(double(y));
                       
end
end