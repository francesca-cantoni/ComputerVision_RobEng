%adding salt and pepper noise to theinput image
function out= addsaltandpepper(IN_image,noise,a)
IN_image=double(IN_image);
[row,col]=size(IN_image);
maxv=max(max(IN_image)); %return the brighest value of the input image
indices=full(sprand(row,col,noise)); %Create a random (full) sparse matrix
%matlab masking technique
mask1=indices>0 & indices<0.5;
mask2=indices>=0.5; 
%adding noise 
out= IN_image.*(~mask1) ;
out=out.*(~mask2)+maxv*mask2;

    if a==1
        subplot(4,2,3), imagesc(out), title('salt & pepper noise'), set(gca,'xtick',[],'ytick',[]);
        subplot(4,2,4), imhist(uint8(out),256), title('histogram'), ylim([0 400]), xlabel('Gray levels'),ylabel('#pixel');
    else
        subplot(4,2,7), imagesc(out), title('Gaussian noise + salt & pepper noise'), set(gca,'xtick',[],'ytick',[]);
        subplot(4,2,8), imhist(uint8(out),256), title('histogram'), ylim([0 200]), xlabel('Gray levels'),ylabel('#pixel');
    end
return
