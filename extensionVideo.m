function [OrdonneSuivant] = extensionVideo(old, actual )
%TESTPROCHE Summary of this function goes here
%   Detailed explanation goes here

OrdonneSuivant=zeros(2,4);
for i=1:4
    minimum=realmax;
    for j=1:4
    distance=(actual(1,j)-old(1,i))^2+(actual(2,j)-old(2,i))^2;
        if(distance<minimum)
            minimum=distance;
            OrdonneSuivant(:,i)=actual(:,j);
        end
    end

end
end