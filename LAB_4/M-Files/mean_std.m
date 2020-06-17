%% Computes the mean value and the standard deviation of the Hue component
function [meanH, standar_dev] = mean_std(HSVimage, window)
    [r1 c1 p1]=size(HSVimage);
    [r2 c2 p2]=size(window);
    
    %Hue cirlce took the colour spectrum and wrapped it around, 
    %noticing that the two ends of the spectrum (where the reds become bluish and the blues become reddish) 
    %look rather similar. 'rgb2hsv'represents elements in the interval 0 to 1.
    %To compute correctly the meand and  thestandard deviation parameters 
    %is necessary to delete the gap between the elements near to the zero value
    %and the elements near the unit value.
    
    if r1==r2
        %considering the manually selected region 
        hue_cut=HSVimage(:,:,1);
        hue_cut=hue_cut(window);
        for i=1:r1
            for j=1:c1
                if hue_cut(i,j)<0.1
                            hue_cut(i,j)=hue_cut(i,j)+1;
            end
            end
        end
    else
        %considering the default region 
        hue_cut=rgb2hsv(window);
        hue_cut=hue_cut(:,:,1);
        for i=1:r2
            for j=1:c2
                if hue_cut(i,j)<0.1
                            hue_cut(i,j)=hue_cut(i,j)+1;
            end
            end
        end
    end
    % computes the mean of the values in hue_cut
    meanH=mean2(hue_cut);
    
    %computes the standard deviation of the values in hue_cut
    standar_dev=std2(hue_cut);
    
    fprintf('tested image: ur_c_s_03a_01_L_0376.png\n');
    fprintf('mean of the Hue values of the car section:\n mean:\t%d \n standard deviation:\t%d\n\n\n',meanH ,standar_dev);

return
