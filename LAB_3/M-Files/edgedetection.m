%% set the parameters of edgedetect(INimage,sig,coeff,th,row)
% INimage -> input image on which it will be performed edge detection 
%             operation
% sig -> value of sigma related to the LoG operator
% coeff -> value that influences the dimension of the spatial support
%          REMARK: is better to mantain this value greater or
%                  equal to 3
% th -> threshold value using inside zeroCrossing() function
% row -> # of row in each subplot 

function edgedetection(INimage,sig,coeff,th,thstep,row)
    %% grayscale check:
    imageGray = imread(INimage);
    [X,Y,Z] = size(imageGray);

    if (Z>1)
        %performed only for RGB images
        imageGray=rgb2gray(imageGray);
    end
    
    imageGray=double(imageGray(1:256,1:256));
    figure;
    sgtitle('Edge detection with zero-crossing');
    
    k=6;    %number of columns inside the subplot
    for i=1:row
        %% input image
        subplot(row,k,3+(i-1)*k), imagesc(imageGray), colormap gray, set(gca, 'xtick',[],'ytick',[]);
        
        %% Laplacian of Gaussian Operator
        lap=LoG(sig,coeff);
        subplot(row,k,1+(i-1)*k), surf(lap), title(['sigma = ', num2str(sig)]);
        subplot(row,k,2+(i-1)*k), imagesc(lap), title(['coeff = ', num2str(coeff)]);
        
        
        %% Convolution between image and LoG
        out(:,:,i)=conv2(imageGray, lap, 'same');
        subplot(row,k,4+(i-1)*k), imagesc(out(:,:,i)), set(gca, 'xtick',[],'ytick',[]);
        
        %% zero crossing detection
        edge_detection = zeroCrossing(out(:,:,i),th);
        subplot(row,k,5+(i-1)*k), imagesc(~edge_detection), set(gca, 'xtick',[],'ytick',[]), title(['threshold = ', num2str(th)]);
        
        %% Matlab function: edge(I,'log',THRESH,SIGMA)
        out_fun = edge(out(:,:,i),'log',[],sig);
        
        subplot(row,k,6+(i-1)*k), imagesc(~out_fun), set(gca, 'xtick',[],'ytick',[]), title('threshold = automatic');
    
        %% Comparison
        
        comparison = out_fun-edge_detection;
        disp('Points not found')
        disp(comparison)
        
        th=th+thstep;
    end
end