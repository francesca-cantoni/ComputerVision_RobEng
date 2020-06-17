close all;
fontSize=18;

%% Read all images and convert them into gray scale

num_image = 5;
IN_gray_scale(:,:,:,1) = rgb2gray(imread('ur_c_s_03a_01_L_0376.png'));
IN_gray_scale(:,:,:,2) = rgb2gray(imread('ur_c_s_03a_01_L_0377.png'));
IN_gray_scale(:,:,:,3) = rgb2gray(imread('ur_c_s_03a_01_L_0379.png'));
IN_gray_scale(:,:,:,4) = rgb2gray(imread('ur_c_s_03a_01_L_0380.png'));
IN_gray_scale(:,:,:,5) = rgb2gray(imread('ur_c_s_03a_01_L_0381.png'));

car_gray_big = rgb2gray(imread('car_big.png'));
car_gray_med = rgb2gray(imread('car_med.png'));
car_gray_small = rgb2gray(imread('car_small.png'));


disp('Positions of the maximum');

%% Performs the NCC-based segmentation for all the given num_image 
for i=1:num_image   
    %% NCC considering a BIG template
    accuracy1 = big_template(IN_gray_scale(:,:,:,i), car_gray_big, i, fontSize);

    %% NCC considering a MED template
    accuracy2 = med_template(IN_gray_scale(:,:,:,i), car_gray_med, i, fontSize);

    %% NCC considering a SMALL template
    accuracy3 = small_template(IN_gray_scale(:,:,:,i), car_gray_small, i, fontSize);
end




