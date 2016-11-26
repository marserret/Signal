close all;

resulta_video=VideoWriter( 'resultat_video.avi');
video_init=VideoReader('vid_in.mp4');

load('sauvegarde.mat')

%seuillage
seuil=50;
ImageMaha=distMaha;
for i=1:size(distMaha,1)
    for j=1:size(distMaha,2)
        if distMaha(i,j) > seuil
            ImageMaha(i,j)=0;
        else ImageMaha(i,j)=1;
        end
    end
end


figure,imagesc(ImageMaha),colorbar
colormap gray


%Labelisation
L=bwlabel(ImageMaha);
[R,c]=find(L==1);
rc1=[R,c];


figure, imshow(L)


 
    %Detection des Barycentres
        nbBar=4;
        NewBarycentres=zeros(nbBar,2);
        
        for i=1:4 %On range les coordonn�es des barycentres dans une matrice 4*2
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
        

    %Ordonnement des 4 picots
       %Sur la premi�re image
    [nbPixelsColonne,nbPixelsLigne,~]=size(ImageMaha);
    
    
    for i=1:nbPixelsColonne
        for j=1:nbPixelsLigne
            if(L(i,j)==1)
                L(i,j)=4;
            elseif(L(i,j)==4)
                L(i,j)=2;
            elseif(L(i,j)==2)
                L(i,j)=1;
            end
        end
    end
    figure, imagesc(L),colorbar %Image labelisee de fa�on ordonn�e
   
    
   X=NewBarycentres(:,2)';
   Y=NewBarycentres(:,1)';
   [dimY,dimX,~]=size(image0);
   mask=zeros([dimY,dimX]);
   X=X(:,[2 4 3 1]);
   Y=Y(:,[2 4 3 1]);
   image1 = imread('trombinoscope.jpg');
   
   MatBary=[X,Y];
   OldBary=MatBary;
   
 Incrus=motif2frame(image1,image0,X,Y,1/1.2,mask);

 imshow(Incrus);
 writeVideo(resulta_video,newFrame);
 
 old_X = X;
 old_Y = Y;

 image_suivante = 2;

 for i=2:video_init.NumberOfFrames
     
 end
    



