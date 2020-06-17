function trasnformation(I)
F = fft2(double(I));
F = abs(F); % Get the magnitude
F = log(F+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1

R=20;
N=101;
X=0:(N-1);
[X Y]=meshgrid(X,X)
Cx=0.5*N;
Cy=Cx;
Lo=exp(-((X-Cx).^2+(Y-Cy).^2)./(2*R).^2);
Lo = abs(Lo);% Get the magnitude
Lo = log(Lo+1);
Lo = mat2gray(Lo); % Use log, for perceptual scaling, and +1 since log(0) is undefined
% Use mat2gray to scale the image between 0 and 1

figure, imagesc(F),colormap gray % Display the result
figure ,imagesc(Lo),colormap gray % Display the result
end
