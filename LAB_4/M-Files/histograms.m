%% input: RGB image. It displays the variation of the RGB components and of the Hue one in the area of the red car on the street
function histograms(RGBimage)
    fontSize=18;
    
    %% Compute and plot RGB components histograms
    figure, set(gcf, 'Position', get(0, 'ScreenSize'));
    sgtitle('RGB and Hue values of the red car ', 'FontSize', fontSize);
   
    just_red = RGBimage(:,:,1);
    just_green = RGBimage(:,:,2);
    just_blue = RGBimage(:,:,3);
	
	% portion of the RGBimage that contains the red car
    subplot(2, 4, 1), imagesc(just_red), colormap gray, 
        title('Red image of red car'), set(gca, 'xtick',[],'ytick',[]);
    subplot(2, 4, 2), imagesc(just_green), colormap gray, 
        title('Green image of the red car'), set(gca, 'xtick',[],'ytick',[]);
    subplot(2, 4, 3), imagesc(just_blue), colormap gray, 
        title('Blue image of the red car'), set(gca, 'xtick',[],'ytick',[]);
    
    % histogram of the Red image
	hR = subplot(2, 4, 5);
	[countsR, grayLevelsR] = imhist(RGBimage(:,:,1));
	maxGLValueR = find(countsR > 0, 1, 'last');
	maxCountR = max(countsR);
	bar(countsR, 'r');
	grid on;
	xlabel('Gray Levels'), ylabel('Pixel Count'), title('Histogram of Red Band');
    
    % histogram of the Green image
	hG = subplot(2, 4, 6);
	[countsG, grayLevelsG] = imhist(RGBimage(:,:,2));
	maxGLValueG = find(countsG > 0, 1, 'last');
	maxCountG = max(countsG);
	bar(countsG, 'g', 'BarWidth', 0.95);
	grid on;
	xlabel('Gray Levels'), ylabel('Pixel Count'), title('Histogram of Green Band');
	
	% histogram of the Blue image
	hB = subplot(2, 4, 7);
	[countsB, grayLevelsB] = imhist(RGBimage(:,:,3));
	maxGLValueB = find(countsB > 0, 1, 'last');
	maxCountB = max(countsB);
	bar(countsB, 'b');
	grid on;
	xlabel('Gray Levels'), ylabel('Pixel Count'), title('Histogram of Blue Band');
    
    %% Compute and plot HSV components' histograms
   
    HSVimage=rgb2hsv(RGBimage);
    
    % Hue value of the red car
	subplot(2, 4, 4), imagesc(HSVimage(:,:,1)), colormap gray, 
        title('Hue image of the red car'), set(gca, 'xtick',[],'ytick',[]);
    
    % histogram of the Hue values
	hH = subplot(2, 4, 8);
	[countsH, grayLevelsH] = imhist(HSVimage(:,:,1));
	maxGLValueH = find(countsH > 0, 1, 'last');
	maxCountH = max(countsH);
	bar(countsH, 'r');
	grid on;
	xlabel('Gray Levels'), ylabel('Pixel Count'), title('Histogram of Hue Band');
	
	%% Set all axes to be the same width and height
	% This makes it easier to compare them
	maxGL = max([maxGLValueR,  maxGLValueG, maxGLValueB, maxGLValueH]);
	maxCount = max([maxCountR,  maxCountG, maxCountB, maxCountH]);
	axis([hR hG hB hH], [0 maxGL 0 maxCount]);
    drawnow;
    print('histograms_car_region','-dpng')
end