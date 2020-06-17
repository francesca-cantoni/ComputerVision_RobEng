%% input: RGB & HSV image representation| coordinates of the considered window.
%% It displays the variation of the RGB components and of the Hue one in 
%% the area of the red car on the street
function histograms2(RGBimage, HSVimage, window, i)
    
    fontSize=18;
    
    % reconstruct the dimension of the blob box (window)
    % BoundingBox = [xLeft, yTop, width, height]
    xMin = ceil(window(1));
    xMax = xMin + window(3) - 1;
    yMin = ceil(window(2));
    yMax = yMin + window(4) - 1;
    
    %% Compute and plot RGB components' histograms
    figure, set(gcf, 'Position', get(0, 'ScreenSize'));
    sgtitle(['RGB histogram image # ', num2str(i)], 'FontSize', fontSize);
    
    a = zeros(size(RGBimage, 1), size(RGBimage, 2));
    just_red = RGBimage(:,:,1);
    just_green = RGBimage(:,:,2);
    just_blue = RGBimage(:,:,3);
	
	% portion of the RGBimage that contains the red car
    subplot(2, 3, 1), imagesc(just_red(yMin:yMax,xMin:xMax)), colormap gray, 
        title('Red image of the blob box only'), set(gca, 'xtick',[],'ytick',[]);
    subplot(2, 3, 2), imagesc(just_green(yMin:yMax,xMin:xMax)), colormap gray, 
        title('Green image of the blob box only'), set(gca, 'xtick',[],'ytick',[]);
    subplot(2, 3, 3), imagesc(just_blue(yMin:yMax,xMin:xMax)), colormap gray, 
        title('Blue image of the blob box only'), set(gca, 'xtick',[],'ytick',[]);
    
    % histogram of the cropped Red image
	hR = subplot(2, 3, 4);
	[countsR, grayLevelsR] = imhist(RGBimage(yMin:yMax,xMin:xMax,1));
	maxGLValueR = find(countsR > 0, 1, 'last');
	maxCountR = max(countsR);
	bar(countsR, 'r');
	grid on;
	xlabel('Gray Levels'), ylabel('Pixel Count'), title('Histogram of Red Band');
    
    % histogram of the cropped Green image
	hG = subplot(2, 3, 5);
	[countsG, grayLevelsG] = imhist(RGBimage(yMin:yMax,xMin:xMax,2));
	maxGLValueG = find(countsG > 0, 1, 'last');
	maxCountG = max(countsG);
	bar(countsG, 'g', 'BarWidth', 0.95);
	grid on;
	xlabel('Gray Levels'), ylabel('Pixel Count'), title('Histogram of Green Band');
	
	% histogram of the cropped Blue image
	hB = subplot(2, 3, 6);
	[countsB, grayLevelsB] = imhist(RGBimage(yMin:yMax,xMin:xMax,3));
	maxGLValueB = find(countsB > 0, 1, 'last');
	maxCountB = max(countsB);
	bar(countsB, 'b');
	grid on;
	xlabel('Gray Levels'), ylabel('Pixel Count'), title('Histogram of Blue Band');
	
	% Set all axes to be the same width and height
	% This makes it easier to compare them
	maxGL = max([maxGLValueR,  maxGLValueG, maxGLValueB]);
    
	maxCount = max([maxCountR,  maxCountG, maxCountB]);
	axis([hR hG hB], [0 maxGL 0 maxCount]);
    drawnow;
    
  
    
    %% Compute and plot HSV components' histograms
    figure, set(gcf, 'Position', get(0, 'ScreenSize'));
    sgtitle(['HSV histogram image # ', num2str(i)], 'FontSize', fontSize);
    
    % portion of the HSVimage that contains the red car
	subplot(2, 3, 1), imagesc(HSVimage(yMin:yMax,xMin:xMax,1)), colormap gray, 
        title('Hue image of the blob box only'), set(gca, 'xtick',[],'ytick',[]);
    subplot(2, 3, 2), imagesc(HSVimage(yMin:yMax,xMin:xMax,2)), colormap gray, 
        title('Saturation mage of the blob box only'), set(gca, 'xtick',[],'ytick',[]);
    subplot(2, 3, 3), imagesc(HSVimage(yMin:yMax,xMin:xMax,3)), colormap gray, 
        title('Value mage of the blob box only'), set(gca, 'xtick',[],'ytick',[]);
    
    
    % histogram of the cropped Hue image
	hH = subplot(2, 3, 4);
	[countsH, grayLevelsH] = imhist(HSVimage(yMin:yMax,xMin:xMax,1));
	maxGLValueH = find(countsH > 0, 1, 'last');
	maxCountH = max(countsH);
	bar(countsH, 'r');
	grid on;
	xlabel('Gray Levels'), ylabel('Pixel Count'), title('Histogram of Hue Band');
    
    % histogram of the cropped Saturation image
	hS = subplot(2, 3, 5);
	[countsS, grayLevelsS] = imhist(HSVimage(yMin:yMax,xMin:xMax,2));
	maxGLValueS = find(countsS > 0, 1, 'last');
	maxCountS = max(countsS);
	bar(countsS, 'g', 'BarWidth', 0.95);
	grid on;
	xlabel('Gray Levels'), ylabel('Pixel Count'), title('Histogram of Saturation Band');
	
	% histogram of the cropped Value image
	hV = subplot(2, 3, 6);
	[countsV, grayLevelsV] = imhist(HSVimage(yMin:yMax,xMin:xMax,3));
	maxGLValueV = find(countsV > 0, 1, 'last');
	maxCountV = max(countsV);
	bar(countsV, 'b');
	grid on;
	xlabel('Gray Levels'), ylabel('Pixel Count'), title('Histogram of Value Band');
	
	% Set all axes to be the same width and height
	% This makes it easier to compare them
	maxGL = max([maxGLValueH,  maxGLValueS, maxGLValueV]);
    
	maxCount = max([maxCountH,  maxCountS, maxCountV]);
	axis([hH hS hV], [0 maxGL 0 maxCount]);
    drawnow;
    
    
end