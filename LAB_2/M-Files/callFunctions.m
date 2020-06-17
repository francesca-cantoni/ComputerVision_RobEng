%this is the main script that calls all the function that
%perfom the requested manipulations
%
function callFunctions(IN_image)
image_gray = imread(IN_image);
[X,Y,Z] = size(image_gray);
%grayscale check:
if (Z>1)
    %performed only for RGB images
    image_gray=rgb2gray(image_gray);
end
figure
%main title for the subplot
sgtitle('Comparison between images with and without noise');
%subplot(#colums, #rows, position)
subplot(4,2,1), imagesc(image_gray), colormap gray, title('original input image'), set(gca,'xtick',[],'ytick',[]);
%input image histogram
subplot(4,2,2), imhist(uint8(image_gray),256), title('histogram'), xlabel('Gray levels'),ylabel('#pixel');

%add different noises to the original image
imn=addnoise(image_gray,20,20);

%apply different filters to the image corrupted with noises
figure
sgtitle('Comparison between image with noises and filtered images');

%moving average
out1 = movav(imn,3);
out2 = movav(imn,7);

%Gaussian filter
out3 = gaussfilt(imn,3,20);
out4 = gaussfilt(imn,7,20);

%median filter
out5 = medfilter(imn,3);
out6 = medfilter(imn,7);

figure
sgtitle('Comparison between image with noises and filtered images');
subplot(4,2,1), imagesc(image_gray), colormap gray, title('original image'), set(gca,'xtick',[],'ytick',[]);
subplot(4,2,2), imagesc(imn), colormap gray, title('image with noises'), set(gca,'xtick',[],'ytick',[]);
subplot(4,2,3), imagesc(out1), colormap gray, title('moving average 3x3'), set(gca,'xtick',[],'ytick',[]);
subplot(4,2,4), imagesc(out2), colormap gray, title('moving average 7x7'), set(gca,'xtick',[],'ytick',[]);
subplot(4,2,5), imagesc(out3), colormap gray, title('Gaussian filter 3x3'), set(gca,'xtick',[],'ytick',[]);
subplot(4,2,6), imagesc(out4), colormap gray, title('Gaussian filter 7x7'), set(gca,'xtick',[],'ytick',[]);
subplot(4,2,7), imagesc(out5), colormap gray, title('median filter 3x3'), set(gca,'xtick',[],'ytick',[]);
subplot(4,2,8), imagesc(out6), colormap gray, title('median filter 7x7'), set(gca,'xtick',[],'ytick',[]);

%effect different linear filters
linfilter(image_gray,7);

%2D Fourier transform
fourierTransform(image_gray);

end