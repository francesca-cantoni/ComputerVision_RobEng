%filtering process
function out=process(IN_image, matav)
[in_row, in_col]=size(IN_image);
[k,k]= size(matav);
out=zeros(in_row, in_col); %initialization of output image
%cross processing between the image and the filter   
    for out_row = (ceil(k/2)):1:(in_row-floor(k/2))
        for out_col = (ceil(k/2)):1:(in_col-floor(k/2))
            out(out_row,out_col)= sum(IN_image((out_row-floor(k/2)):(out_row+floor(k/2)),(out_col-floor(k/2)):(out_col+floor(k/2))).*matav,'all');
        end
    end
return