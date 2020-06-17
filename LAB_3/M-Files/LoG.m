%% Returns the Laplacian of Gaussian Operator value

function Z=LoG(sigma,coeff)
    
    % relation that link sigma and spatial support values
    spat_supp=ceil(sigma*coeff);
    
    % centering of the resultant values
    [X,Y]=meshgrid(-spat_supp:spat_supp);
    
    % equation of the LoG 
    Z=(1/(2*pi*sigma^2))*((X.^2+Y.^2 -2*sigma^2)/sigma^4).*exp(-(X.^2+Y.^2)/(2*sigma^2));
    
return