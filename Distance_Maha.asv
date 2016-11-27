function Maha = Distance_Maha(image, matCov, u)

distMaha= zeros(size(image,1),size(image,2));
for j=1:size(image,1)
    for k=1:size(image,2)
        xi=[image(j,k,1),image(j,k,2),image(j,k,3)];
        distMaha(j,k)=(double(xi)-u)*(matCov^-1)*(double(xi)-u).';
    end
end

Maha = distMaha;