% This function executes a NNC-based segmenteation on the 5 input images, 
% using as a template a cutted image that keeps into account less information
% about the external, it also display all the results and the print
% on the command window the coordinates of the position of the maximum
% inside the score map (that corresponds to the up-left corner of the
% considered template).
% The output it usefull to keep track of the computed accuracy matrix.

function accuracy = med_template(IN_gray_scale, car_gray_med, i, fontSize)
    figure, sgtitle(['Detect patch inside original image # ',num2str(i), ' MED'],'FontSize', fontSize);
    
    % The function below computes the normalized cross-correlation between 
    % the input image and the template
	% The resulting matrix NNC represents the score map
    NCC = normxcorr2(car_gray_med, IN_gray_scale(:,:,:,1));
    [row, col] = size(car_gray_med);
    
    % The following line return the max value of the NNC matrix.
	% The max value of NNC corresponds to the area that best match the 
    % template insidethe input image (this quantity is identify thorugh
    % the up-left corner coordinates)
    [ypeak, xpeak] = find(NCC==max(NCC(:)));
    
    % These lines compute the 'coordinates' of the center of the template 
    % wtr to the input pixels grid
    yoffSet = ypeak-row;
    xoffSet = xpeak-col;
    
    subplot(2,2,1), imagesc(IN_gray_scale(:,:,:,1)), title('Original image gray'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
    subplot(2,2,2), imagesc(car_gray_med), title('Med window'), colormap gray, set(gca, 'xtick',[],'ytick',[]), truesize([200 200]);
    subplot(2,2,3), surf(NCC), shading flat, title('NCC operation'), colormap gray;
    hold on;
    plot(xpeak,ypeak,'*r');
    view(0,-90);

    subplot(2,2,4), imshow(IN_gray_scale(:,:,:,1)), title('Detected window'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
    hold on;
    rectangle('Position', [xoffSet+1, yoffSet+1, col, row],'EdgeColor',[1,0,0]);
    drawnow;
    var_1 = int2str(i);
    var_1 = ['Detect_patch_inside_original_image_MED_', var_1];
    print( var_1, '-dpng');
    
    % Displays of the NCC peak coordinates
    X = ['MED WINDOW -->  ','   x:', num2str(xpeak) , '   y:', num2str(ypeak) ];
    disp(X)
    
    % The following lines want to displaty the differences between the template 
    % and the detected area: the more white pixels are present the more 
    % unconsistence is the detection
    figure, sgtitle(['Accuracy # ',num2str(i), ' MED'],'FontSize', fontSize);
    patch = IN_gray_scale(yoffSet+1:yoffSet+row, xoffSet+1:xoffSet+col, :, 1);
    subplot(2,2,1), imagesc(IN_gray_scale(:,:,:,1)), title('Original image gray'), colormap gray, set(gca, 'xtick',[],'ytick',[]);
    subplot(2,2,2), imagesc(car_gray_med), title('Med window'), colormap gray, truesize([200 200]);
    subplot(2,2,3), imagesc(patch), title('Detected patch inside original image'), colormap gray;
    disp(patch);
    accuracy = double(patch) - double(car_gray_med);
    A = ['ACCURACY using MED template and relative to image # ', num2str(i)];
    disp(A);
    disp(accuracy);
    accuracy_abs = abs(accuracy); 
    
    subplot(2,2,4), imagesc(accuracy_abs), title('Accuracy'), colormap gray;
    drawnow;
    var_2 = int2str(i);
    var_2 = ['Accuracy_image_MED_', var_2];
    print( var_2 , '-dpng');
end