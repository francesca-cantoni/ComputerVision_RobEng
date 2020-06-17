%this function executes an image warping by backward mapping. It rotates IN_image by an angle theta, then prints on the screen the manipulated image
function image_rot = rotation (IN_image, theta)

%get the size of the input image
[row,col] = size(IN_image);

% column: x --> X   row: y --> Y
[X,Y] = meshgrid(1:col,1:row);         
    
%Let use the center of the image as rotation axis
X_cent = X - floor(col/2); 
Y_cent = Y - floor(row/2);

%Apply inverse mapping function to find corresponding x and y input pixels
X_rot = X_cent * cos(theta) - Y_cent * sin(theta) + floor(col/2);
Y_rot = X_cent * sin(theta) + Y_cent * cos(theta) + floor(row/2);

%linear interpolation
image_rot = griddata(X,Y, double(IN_image), X_rot, Y_rot, 'linear');

%print on the screen the warped image
figure
imagesc(image_rot)
colormap gray
title('rotated image')

end
