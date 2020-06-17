%median filtering
function out=medfilter(IN_image, n)
out= medfilt2(IN_image, [n n]); %filtering process with a nxn mask

    if (n==3)
            subplot(7,4,21), imagesc(out), colormap gray, title('image filtered with median filter'), set(gca,'xtick',[],'ytick',[]);
            subplot(7,4,22), imhist(uint8(out),256), title('histogram'), ylim([0, 400]), xlabel('Gray levels'),ylabel('#pixel');
            
    elseif(n==7)
            subplot(7,4,25), imagesc(out), colormap gray, title('image filtered with median filter'), set(gca,'xtick',[],'ytick',[]);
            subplot(7,4,26), imhist(uint8(out),256), title('histogram'), ylim([0, 400]), xlabel('Gray levels'),ylabel('#pixel');
    end
return
