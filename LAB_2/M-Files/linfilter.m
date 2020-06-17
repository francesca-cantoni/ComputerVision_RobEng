%linear filters implementation
function linfilter(IN_image, n)
IN_image=double(IN_image);
matav1=zeros(n); matav2=zeros(n); matav3=zeros(n);

matav1(ceil(n/2),ceil(n/2))=1; %no changes filter
matav2(ceil(n/2),n)=1; % 1 pixel shifted left filter 
matav3(ceil(n/2),ceil(n/2))=2;
matav4=(1/n^2)*ones(n);
matav5=matav3-matav4; %sharping filter


%display the linear filters
disp('matav1:')
disp(matav1)
disp('matav2:')
disp(matav2)
disp('matav3:')
disp(matav3)
disp('matav4:')
disp(matav4)
disp('matav5:')
disp(matav5)

%filtering process
output1=process(double(IN_image),matav1);
output2=process(double(IN_image),matav2);
output3=process(double(IN_image),matav5);

figure
sgtitle('Different linear filters');
subplot(2,2,1), imagesc(IN_image), colormap gray, title('original image'),set(gca,'xtick',[],'ytick',[]);
subplot(2,2,2), imagesc(uint8(output1)), colormap gray, title('filtered image with no changes'), set(gca,'xtick',[],'ytick',[]);
subplot(2,2,3), imagesc(uint8(output2)), colormap gray, title('image shifted left by one pixel'), set(gca,'xtick',[],'ytick',[]);
subplot(2,2,4), imagesc(uint8(output3)), colormap gray, title('sharped image'), set(gca,'xtick',[],'ytick',[]);

end