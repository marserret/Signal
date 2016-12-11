function [Ordonne] = Ordonner_barycentre(precedent, suivant)
%Fonction permettant de trier les barycentres en fonctions de leurs
%positions et des positions de anciens barycentres

Ordonne=zeros(2,4);

for i=1:4
    
    minimum=realmax;
    
    for j=1:4
        
    distance = (suivant(1,j)-precedent(1,i))^2+(suivant(2,j)-precedent(2,i))^2;
        
    if(distance<minimum)
            minimum = distance;
            Ordonne(:,i) = suivant(:,j);
    end
        
    end

end
end