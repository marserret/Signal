function Selection = Selection_zone(image)

    [x,y] = ginput(2);
    Selection=image(min(y):max(y),min(x):max(x),:);
    imshow(Selection);

end