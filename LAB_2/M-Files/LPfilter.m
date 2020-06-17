function LPfilter(IN)
A = fft2(double(IN)); % compute FFT of the grey image
A1=fftshift(A); % frequency scaling
% Gaussian Filter Response Calculation
[M N]=size(A) % image size
sigma=9; % filter size parameter 
X=0:N-1;
Y=0:M-1;
[X Y]=meshgrid(X,Y);
Cx=0.5*N;
Cy=0.5*M;
Lo=(1./(pi.*2.*(sigma.^2))).*exp(-((X-Cx).^2+(Y-Cy).^2)./(2*sigma).^2);
% Filtered image=ifft(filter response*fft(original image))
%Ji=A1.*Lo;
%J1=ifftshift(Ji);
%B1=ifft2(J1);
out=imfilter(IN,Lo);
figure
imagesc(abs(Lo)), colormap gray
title('fft of gaussian filter')

figure, imshowpair(IN,out,'montage'),set(gca,'xtick',[],'ytick',[])
title('input image VS low pass filtered image')


figure
   mesh(X,Y,Lo)
   axis([ 0 N 0 M 0 1])
   h=gca; 
   get(h,'FontSize') 
   set(h,'FontSize',14)
   title('Gaussian LPF H(f)','fontsize',14)

end
