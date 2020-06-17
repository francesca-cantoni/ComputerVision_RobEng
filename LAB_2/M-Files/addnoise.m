% adding different type of noises to the input image
function out2 = addnoise(IN_image, sigma, noise)
%noise: salt and pepper
addsaltandpepper(IN_image,noise,1);
%noise: gaussian
out1 = addgaussian(IN_image,sigma);
%noise: salt and pepper + gaussian
out2 = addsaltandpepper(out1,noise,2);
return

