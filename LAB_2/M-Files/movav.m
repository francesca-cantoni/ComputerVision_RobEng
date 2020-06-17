%moving average filtering with a nxn kernel 
function out=movav(IN_image,n)
IN_image=double(IN_image);
subplot(7,4,1), imagesc(IN_image), colormap gray, title('image with noises'), set(gca,'xtick',[],'ytick',[]);
subplot(7,4,2), imhist(uint8(IN_image),256), title('histogram'), ylim([0, 250]), xlabel('Gray levels'),ylabel('#pixel');

vector=ones(1,n)/n; %1D kernel

    if (n==3)
        %performing a one-dimensional horizontal convolution 
        %followed by a one-dimensional vertical convolution
        out=conv2(conv2(IN_image, vector),vector');
        
        subplot(7,4,5), imagesc(uint8(out)), colormap gray, title('image filtered with moving average'), set(gca,'xtick',[],'ytick',[]);
        subplot(7,4,6), imhist(uint8(out),256), title('histogram'), xlabel('Gray levels'),ylabel('#pixel');
        
        mat_plus=matrix(3); %increase the size of the 2D kernel
        subplot(7,4,7), surf(mat_plus), title('filter with kernel 3x3');
        subplot(7,4,8), imagesc(mat_plus), title('filter with kernel 3x3');
        
    elseif(n==7)
        %performing a one-dimensional horizontal convolution 
        %followed by a one-dimensional vertical convolution
        out=conv2(conv2(IN_image, vector),vector');
        
        subplot(7,4,9), imagesc(uint8(out)), colormap gray, title('image filtered with moving average'), set(gca,'xtick',[],'ytick',[]);
        subplot(7,4,10), imhist(uint8(out),256), title('histogram'), xlabel('Gray levels'),ylabel('#pixel');
        mat_plus=matrix(7); %increase the size of the 2D kernel
        subplot(7,4,11), surf(mat_plus), title('filter with kernel 7x7');
        subplot(7,4,12), imagesc(mat_plus), title('filter with kernel 7x7');
    end
return
