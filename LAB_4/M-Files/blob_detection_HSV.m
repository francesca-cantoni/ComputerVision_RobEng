%% Segment the red car by thresholding the Hue component
function blob_detection_HSV(RGBimage, HSVimage, center_value, variation, i)

    fontSize=18;
    % subplot fullscreen
    figure, set(gcf, 'Position', get(0, 'ScreenSize'));
    sgtitle(['HSV Blobs detection image # ', num2str(i)], 'FontSize', fontSize);
    
    
    % HSV channels
    just_hue = HSVimage(:,:,1);
    just_saturation = HSVimage(:,:,2);
    just_value = HSVimage(:,:,3);
    
    
    subplot(2,3,1), imagesc(just_hue), title('Hue channel'),colormap gray, set(gca, 'xtick',[],'ytick',[]);
    subplot(2,3,2), imagesc(just_saturation), title('Saturation channel'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
    subplot(2,3,3), imagesc(just_value), title('Value channel'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
	
    % Threshold values 
    % graytresh = graythresh(I) computes a global threshold that can be
    % used to convert an intensity image to a binary image [0,1]
    
	hueThresholdLow = center_value-3*variation;
	hueThresholdHigh = center_value+3*variation;

    % Define the corrispondent mask for the hue component
	hueMask = (HSVimage(:, :, 1) >= hueThresholdLow) & (HSVimage(:, :, 1) <= hueThresholdHigh);
    subplot(2, 3, 4), imshow(hueMask, []), colormap gray, title('Is-Hue Mask');
     
    redObjectsMask = uint8(hueMask);
    
    % filtering process: creation of a nxn Gaussian filter with normal distribution equals to sigma
    h = fspecial('gaussian', 3, 0.5); 
    redObjectsMask = imfilter(redObjectsMask, h);
   
    % smallest area to keep into account (to discard the noise)
    smallestAcceptableArea=100;
    
    % remove from the binary image all the objects that have fewer than P 
    % pixels and produce another binary image with bwareaopen()
    redObjectsMask = uint8(bwareaopen(redObjectsMask, smallestAcceptableArea));
	subplot(2, 3, 5), imshow(redObjectsMask, []), colormap gray, title('Mantain only big areas');
    
      
    % Smooth the border using a morphological closing operation with imclose()
	structuringElement = strel('disk', 4);
	redObjectsMask = imclose(redObjectsMask, structuringElement);
    
    % filled each blob area with imfill()
    redObjectsMask = uint8(imfill(redObjectsMask, 'holes'));
    subplot(2, 3, 6), imshow(redObjectsMask, []), colormap gray, title('Smoothed and filled outlines');
    drawnow;
    print('blob_HSV_mask','-dpng')
    
    % We need to convert the type of redObjectsMask to the same data type of 
    % the matrix of HSVimage associate to the red color
    % (redObjectsMask is a logical array)
	redObjectsMask = cast(redObjectsMask, class(RGBimage));
	
	% Use the red object mask to mask out the red-only portions of the rgb image
	maskedImageR = redObjectsMask .* RGBimage(:,:,1);
	maskedImageG = redObjectsMask .* RGBimage(:,:,2);
	maskedImageB = redObjectsMask .* RGBimage(:,:,3);
    
	% Show the masked off red image

    
	% Concatenate the masked color bands to form the rgb image
	maskedRGBImage = cat(3, maskedImageR, maskedImageG, maskedImageB);

    
    % binarize the image using 0 threshold with imbinarize()
    BW = imbinarize(redObjectsMask,0);
    
    % sort the objects based on the attribute 'area' and keep the
    % largest value with bwpropfilt()
    BW2 = bwpropfilt(BW,'area',1);
    
    % measure a set of properties for each object in the binary
    % image BW2 with regionprops() 
    prop=regionprops(BW2, 'Area','Centroid','BoundingBox');
    
    disp('Properties:')
    disp(prop)
    % Centroid
    xc=floor(prop(1).Centroid(1));
    yc=floor(prop(1).Centroid(2));
    % BoundingBox
    window=prop(1).BoundingBox;
    

				figure, imagesc(BW), colormap gray, set(gca, 'xtick',[],'ytick',[]);
    hold on
    plot(xc,yc,'*r')    %shows the centroid
    rectangle('Position',window,'EdgeColor',[1,0,0]) %shows the rectangle
    drawnow;
    print('detected','-dpng')
    
end
