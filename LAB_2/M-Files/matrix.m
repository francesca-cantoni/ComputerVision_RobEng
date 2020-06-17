%in order to better display the filter
%a frame of zeros is added
function matav=matrix(n)
plus=3; %size of the frame
k=n+2*plus;
matav=zeros(k);
%adding the frame to the filter
    for i=1:k
        for j=1:k
            if (j>plus) && j<=(k-plus) && i>plus && i<=(k-plus)
                    matav(i,j)=1/(n*n);
            else 
                matav(i,j)=0;
            end
        end
    end

disp('2D kernel surrounded by zeros')
disp(matav)
return