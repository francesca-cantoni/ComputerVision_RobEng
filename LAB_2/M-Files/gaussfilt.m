%Gaussian filtering
function out=gaussfilt(IN_image, n, sigma)
h = fspecial('gaussian', n, sigma); %creation of a nxn Gaussian filter with normal distribution equals to sigma
out = imfilter(IN_image, h); %filtering process

    if (n==3)
        subplot(7,4,13), imagesc(out), colormap gray, title('image filtered with Gaussian filter'), set(gca,'xtick',[],'ytick',[]);
        subplot(7,4,14), imhist(uint8(out),256), title('histogram'), ylim([0, 600]), xlabel('Gray levels'),ylabel('#pixel');
        subplot(7,4,15), surf(h), title('filter with kernel 3x3');
        subplot(7,4,16), imagesc(h), title('filter with kernel 3x3');

    elseif(n==7)
        subplot(7,4,17), imagesc(out), colormap gray, title('image filtered with Gaussian filter'), set(gca,'xtick',[],'ytick',[]);
        subplot(7,4,18), imhist(uint8(out),256), title('histogram'), ylim([0, 900]), xlabel('Gray levels'),ylabel('#pixel');
        subplot(7,4,19), surf(h), title('filter with kernel 7x7');
        subplot(7,4,20), imagesc(h), title('filter with kernel 7x7');
    end
    
return
