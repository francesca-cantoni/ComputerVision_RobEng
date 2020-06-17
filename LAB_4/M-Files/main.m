close all;

%% Read image
num_image = 4;
% % RGBimage(:,:,:,1) = imread('ur_c_s_03a_01_L_0376.png');
% RGBimage(:,:,:,2) = imread('ur_c_s_03a_01_L_0377.png');
% RGBimage(:,:,:,3) = imread('ur_c_s_03a_01_L_0379.png');
% RGBimage(:,:,:,4) = imread('ur_c_s_03a_01_L_0380.png');
% RGBimage(:,:,:,5) = imread('ur_c_s_03a_01_L_0381.png');

RGBimage(:,:,:,1) = imread('ur_c_s_03a_01_L_0377.png');
RGBimage(:,:,:,2) = imread('ur_c_s_03a_01_L_0379.png'); 
RGBimage(:,:,:,3) = imread('ur_c_s_03a_01_L_0380.png'); 
RGBimage(:,:,:,4) = imread('ur_c_s_03a_01_L_0381.png');


%% 1) split into RGB and HSV channels
 for i=1:num_image
   RGB_channels(RGBimage(:,:,:,i),i);
   HSVimage(:,:,:,i) = HSV_channels(RGBimage(:,:,:,i));
 end

%% 2) variation of the RGB components and of the Hue one
car=imread('car.png');
histograms(car);

%% 3) compute the mean value and the standard deviation of the Hue component 
%%    in the red car region
% selected area corresponding to the red car
sample_region= imread('car_region.png');

%uncommet the following two lines to select manually the region
% figure, title('select the desired region');
% sample_region = roipoly(RGBimage(:,:,:,1));

[meanH, standar_dev] = mean_std(HSVimage(:,:,:,1),sample_region);

%% 4) & 5) blobs detection using Hue value 
for i=1:num_image    
    HSVimage(:,:,:,i)= rgb2hsv(RGBimage(:,:,:,i));
    blob_detection_HSV(RGBimage(:,:,:,i), HSVimage(:,:,:,i), meanH, standar_dev, i);
end

%% Auxiliary section
%% 2) & 3b) Blob detection through RGB  mask
% for i=1:num_image
%     % size of the area in which there is the desired red car
%     % performed using the RGB blobs detection 
%     window = blob_detection_RGB(RGBimage(:,:,:,i),i);
%     % RGB and HSV histograms of the blob area  
%     histograms2(RGBimage(:,:,:,i), HSVimage(:,:,:,i), window, i);
% end