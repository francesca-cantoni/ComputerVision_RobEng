%% EDGE DETECTION %%
close all;

%% possible input images
INimage1='boccadasse.jpg';
INimage2='left_#290gray.bmp';
INimage3='car.bmp';
INimage4='cameraman.tif';

%% cycles(INimage,mainLoop,row,sig,sigstep,coeff,coeffstep,th,thstep)
% INimage -> input image on which it will be performed edge detection 
%             operation
% mainLoop -> number of subplot displayed maintaining the values of sigma and 
%             spatial dimension unchanged , and varying just the threshold 
%             value at each iteration 
% row -> # of row in each subplot 
% sig -> value of sigma related to the LoG operator
% sigstep -> increment value of sigma added to the previous one after 
%           mainloop iterations
% coeff -> value that influences the dimension of the spatial support
%          REMARK: is better to mantain this value greater or
%                  equal to 3
% th -> threshold value using inside zeroCrossing() function
% thstep -> increment value of the threshold added to the previous one at each 
%           iteration of edgedetect() function


%% cycles(INimage,mainLoop,row,sig,sigstep,coeff,th,thstep)
%% cameramen
   cycles(INimage4, 4, 3, 0.5, 0.3, 3, 0, 0.15);
   

