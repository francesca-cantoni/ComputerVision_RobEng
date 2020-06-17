%this function executes a centered zooming IN_image with a ratio equals to z. then prints on the screen the manipulated image
function zoom(image,z)

%get the size of the input image
[X,Y]= size(image);

zoomX=X/z;
zoomY=Y/z;

%samplig the input image with ratio equals to z
zoomimage= image(floor((X/2)-zoomX/2):floor((X/2)+zoomX/2),floor((Y/2)-zoomY/2):floor((Y/2)+zoomY/2));

%print on the screen the warped image
figure;
imagesc(zoomimage);
colormap gray;
t=['input image zoomed'];
title(t);

end
