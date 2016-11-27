function Label = Labelisation(ImageMaha)

L=bwlabel(ImageMaha);
[R,c]=find(L==1);

Label = [R,c];


