% adding gaussian noise to the input image
function out= addgaussian(IN_image,sigma)
%intensity distorsion drawn by a Gaussian distribuitiion
out=double(IN_image)+sigma*randn(size(IN_image));
subplot(4,2,5), imagesc(out), title('Gaussian noise'), set(gca,'xtick',[],'ytick',[]);
subplot(4,2,6), imhist(uint8(out),256), title('histogram'), xlabel('Gray levels'),ylabel('#pixel');
return
