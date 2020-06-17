%% input: RGB image. It displays the 3 channels
function RGB_channels(RGBimage,i)

    fontSize=18;
    
    % subplot fullscreen
    figure, set(gcf, 'Position', get(0, 'ScreenSize'));
    sgtitle(['Split into RGB and HSV channels image # ', num2str(i)], 'FontSize', fontSize);
    
    red = RGBimage(:,:,1); % Red channel
    green = RGBimage(:,:,2); % Green channel
    blue = RGBimage(:,:,3); % Blue channel
    
    subplot(2,3,1), imagesc(red), title('Red channel'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
    subplot(2,3,2), imagesc(green), title('Green channel'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
    subplot(2,3,3), imagesc(blue), title('Blue channel'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
end