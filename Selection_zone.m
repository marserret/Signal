function [Selection, x, y] = Selection_zone(image)
%fonction permettant de s�lectionner une zone dans l'image � partir de 2
%points

    [x,y] = ginput(2);
    Selection=image(min(y):max(y),min(x):max(x),:);

end