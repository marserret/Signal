function [Detection] = Detection_barycentre(L, NewBarycentres)

for i=1:4 %On range les coordonnées des barycentres dans une matrice 4*2
            B=DetectionBary(L,i);
            NewBarycentres(i,1)=B(1);
            NewBarycentres(i,2)=B(2);
            
            bar = [B(1),B(2)];
            if (i==1)
                bar1 = bar;          
            elseif (i==2)
                bar2=bar;
                 elseif (i==3)
                bar3=bar;
                   elseif (i==4)
                bar4=bar;
            end
end

[Detection] = [bar1 bar2 bar3 bar4];