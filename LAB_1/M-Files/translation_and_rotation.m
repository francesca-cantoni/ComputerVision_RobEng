%this function executes an image warping by backward mapping. 
%It rotates IN_image by an angle theta.
%It translates IN_image by X_offset and Y_offset pixels corrispectively on the x and y axes
% then prints on the screen the manipulated image
function image_rot_transl = translation_and_rotation(IN_image, theta, X_offset, Y_offset)

%size
[row,col] = size(IN_image);

% column: x --> X   row: y --> Y
[X,Y] = meshgrid(1:col,1:row);     
    
%Let use the center of the image as rotation axis
X_cent = X - floor(col/2); 
Y_cent = Y - floor(row/2);

%Apply inverse mapping function to find corresponding x and y input pixels
X_fin = (X_cent + X_offset) * cos(theta) - (Y_cent + Y_offset) * sin(theta) + floor(col/2);
Y_fin = (X_cent + X_offset) * sin(theta) + (Y_cent + Y_offset) * cos(theta) + floor(row/2);

%interpolation
image_rot_transl = griddata(X,Y, double(IN_image), X_fin, Y_fin, 'linear');

%print on the screen the warped image
figure
imagesc(image_rot_transl)
colormap gray
title('translated and rotated image')

end
