%%main function: the input image is loaded, greyscaled and manipulated
close all;
%open in the workspace the image
image_color = imread('flower.jpg');
figure;
imagesc(image_color);
title('original image with color');

%from RGB to gray-scale color
image_gray = rgb2gray(image_color);
figure;
imagesc(image_gray);
colormap gray;
title('original image with greyscale');

%call the function 'rotation'
rotated_image = rotation(image_gray, -pi/3);         % theta<0 cloclwise
                                                     % theta>0 counterclockwise
                                                    
%call the function 'translation'
translated_image = translation(image_gray, 50, 60);   %(X_offset, Y_offset)

%call the function 'translation_and_rotation'
translated_rotated_image = translation_and_rotation(image_gray, pi/4, 100, 100);  %(theta, X_offset, Y_offset);

%%call zooming function
zoom(image_gray,1.5);
