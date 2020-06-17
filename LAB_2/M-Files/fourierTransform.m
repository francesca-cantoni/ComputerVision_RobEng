%Fourier Transform manipulation
function fourierTransform(IN_image)
%image processing
F = fft2(double(IN_image)); %2D discrete Fast Fourier Transform
F = fftshift(F); %shifting the zero-frequency component to center of spectrum
F = abs(F);                     %get the magnitude of the trasformed image
F = log(F+1);                   %use log, for perceptual scaling, and +1 since log(0) is undefined

%low-pass Gaussin filters processing
n=101; %dimension of Gaussian filter
sigma=5; %spread

Cx=0.5*n; Cy=Cx; %center coordinates of the function

[X1, Y1]=meshgrid(1:n);
Z = (1/((2*pi*(sigma.^2))).*exp((-((X1-Cx).^2+(Y1-Cy).^2))./(2*(sigma).^2))); %two-dimensional Gaussian function
Z = abs(Z);                     %get the magnitude
Z = log(Z+1);                   %log for logarithmic scaling, and +1 since log(0) is undefined

figure
sgtitle('Fourier Transform');
subplot(2,2,1), imagesc(F),title('Magnitude of the transformed image'),xlabel('wx'),ylabel('wy');
subplot(2,2,2), mesh(F),xlabel('wx'),ylabel('wy'),zlabel('abs(F)');
subplot(2,2,3), imagesc(Z), title('Magnitude of the LP Gaussian filter'), xlabel('x'),ylabel('y');
subplot(2,2,4), mesh(Z),xlabel('x'),ylabel('y'),zlabel('z');
end
