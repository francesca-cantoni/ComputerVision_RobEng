%this function executes an image warping by backward mapping. It translates IN_image by X_offset and Y_offset pixels corrispectively on the x and y axes, then prints on the screen the manipulated image
function image_transl = translation (IN_image, X_offset, Y_offset)

%get the size of the input image
[row,col] = size(IN_image);

% column: x --> X   row: y --> Y
[X,Y] = meshgrid(1:col,1:row);

%Apply inverse mapping function to find corresponding x and y input pixels
X_trans = (X + X_offset);
Y_trans = (Y + Y_offset);

%linear interpolation
image_transl = griddata(X,Y,double(IN_image),X_trans,Y_trans,'linear');

%print on the screen the warped image
figure
imagesc(image_transl)
colormap gray
title('translated image')

end
