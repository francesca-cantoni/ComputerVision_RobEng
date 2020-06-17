%% %Segment the red car by thresholding the Hue component
function window = blob_detection_RGB(RGBimage, i)

    fontSize = 18;
    % subplot fullscreen
    figure, set(gcf, 'Position', get(0, 'ScreenSize'));
    sgtitle(['RGB Blobs detection image # ', num2str(i)], 'FontSize', fontSize);
    
    % RGB channels
    red = RGBimage(:,:,1); % Red channel
    green = RGBimage(:,:,2); % Green channel
    blue = RGBimage(:,:,3); % Blue channel
    
    subplot(3,3,1), imagesc(red), title('Red channel'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
    subplot(3,3,2), imagesc(green), title('Green channel'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
    subplot(3,3,3), imagesc(blue), title('Blue channel'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
	
    % Threshold values 
    % graytresh = graythresh(I) computes a global threshold that can be
    % used to convert an intensity image to a binary image [0,1]
    
	redThresholdLow = (graythresh(RGBimage(:, :, 1))*255)-10;
	redThresholdHigh = 255;
	greenThresholdLow = 0;
	greenThresholdHigh = (graythresh(RGBimage(:, :, 2))*255);
	blueThresholdLow = 0;
	blueThresholdHigh = (graythresh(RGBimage(:, :, 3))*255);
    
    % Define the corrispondent mask for each color 
	redMask = (RGBimage(:, :, 1) >= redThresholdLow) & (RGBimage(:, :, 1) <= redThresholdHigh);
	greenMask = (RGBimage(:, :, 2) >= greenThresholdLow) & (RGBimage(:, :, 2) <= greenThresholdHigh);
	blueMask = (RGBimage(:, :, 3) >= blueThresholdLow) & (RGBimage(:, :, 3) <= blueThresholdHigh);
    
    subplot(3, 3, 4), imshow(redMask, []), title('Is-Red Mask');
	subplot(3, 3, 5), imshow(greenMask, []), title('Is-Not-Green Mask');
	subplot(3, 3, 6), imshow(blueMask, []), title('Is-Not-Blue Mask');
    
	% Combine the masks to find where all 3 are "true"
	% Then we will have the mask of only the red parts of the image
	redObjectsMask = uint8(redMask & greenMask & blueMask);
	subplot(3, 3, 7), imshow(redObjectsMask, []), colormap gray, title('Combination of all masks');  
    
    % smallest area to keep into account (to discard the noise)
    smallestAcceptableArea=50;
    
    % remove from the binary image all the objects that have fewer than P 
    % pixels and produce another binary image with bwareaopen()
    redObjectsMask = uint8(bwareaopen(redObjectsMask, smallestAcceptableArea));
	subplot(3, 3, 8), imshow(redObjectsMask, []), colormap gray, title('Mantain only big areas');
    
      
    % Smooth the border using a morphological closing operation with imclose()
	structuringElement = strel('disk', 4); 
	redObjectsMask = imclose(redObjectsMask, structuringElement);
    
    % filled each blob area with imfill()
    redObjectsMask = uint8(imfill(redObjectsMask, 'holes'));
    
    subplot(3, 3, 9), imshow(redObjectsMask, []), colormap gray, title('Smoothed and filled outlines');
    drawnow;
    
    
	% We need to convert the type of redObjectsMask to the same data type of 
    % the matrix of RGBimage associate to the red color
    % (redObjectsMask is a logical array)
	redObjectsMask = cast(redObjectsMask, class(RGBimage(:,:,1)));
	
	% Use the red object mask to mask out the red-only portions of the rgb image
	maskedImageR = redObjectsMask .* RGBimage(:,:,1);
	maskedImageG = redObjectsMask .* RGBimage(:,:,2);
	maskedImageB = redObjectsMask .* RGBimage(:,:,3);
    
	% Show the masked off red image
    figure, set(gcf, 'Position', get(0, 'ScreenSize'));
    sgtitle(['Reconstruction of the original image # ', num2str(i)], 'FontSize', fontSize);
    
	% Concatenate the masked color bands to form the rgb image
	maskedRGBImage = cat(3, maskedImageR, maskedImageG, maskedImageB);
	
    % Show the original image 
	subplot(2, 3, 1), imshow(RGBimage), colormap gray, title('Original Image');
    
    % Show the masked off, original image
	subplot(2, 3, 2), imshow(maskedRGBImage), colormap gray, title('Showing Only the Red Objects');
    
    % binarize the image using 0 threshold with imbinarize()
    BW = imbinarize(redObjectsMask,0);
    
    % sort the objects based on the attribute 'perimeter' and keep the
    % largest value with bwpropfilt()
    BW2 = bwpropfilt(BW,'perimeter',1);
    
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
    
    subplot(2,3,3), imagesc(BW2), colormap gray, title('Object with the Largest Perimeter'), set(gca, 'xtick',[],'ytick',[]);
    hold on
    plot(xc,yc,'*r')    %shows the centroid
    rectangle('Position',window,'EdgeColor',[1,0,0]) %shows the rectangle
    drawnow;
    
return


    
 
  
