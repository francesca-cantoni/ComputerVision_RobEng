%% input: RGB image. It returns the HSV image and displays the three channels
function HSV=HSV_channels(RGBimage)
  
    % convertion from RGB into HSV 
    HSV = rgb2hsv(RGBimage);
    subplot(2,3,4), imagesc(HSV(:,:,1)), colormap gray, title('H = Hue'), set(gca, 'xtick',[],'ytick',[]);
    subplot(2,3,5), imagesc(HSV(:,:,2)), colormap gray, title('S = Saturation'), set(gca, 'xtick',[],'ytick',[]);
    subplot(2,3,6), imagesc(HSV(:,:,3)), colormap gray, title('V = Value'), set(gca, 'xtick',[],'ytick',[]);
    drawnow;
    print('RGB_HSV_channels','-dpng')
return