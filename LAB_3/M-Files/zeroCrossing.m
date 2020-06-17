%% Creates and return new matrix in which it is stored all the positions of 
%% the zero crossing find inside LoG_image (previously convolved with LoG operator)

function zeroCrossing = zeroCrossing(LoGimage,threshold)
    [row, col] = size(LoGimage);
    zeroCrossing=zeros(row, col);
    
    %check on rows
    for i=1:row-1
        %check on columns
        for j=1:col-1
            
            if (LoGimage(i,j)>0 && LoGimage(i,j+1)<0)                 % row[+,-]
                if (abs(LoGimage(i,j)+LoGimage(i,j+1))>threshold)
                        zeroCrossing(i,j)=1;
                end
            end
            if (LoGimage(i,j)<0 && LoGimage(i,j+1)>0)             % row[-,+]
                if (abs(LoGimage(i,j)+LoGimage(i,j+1))>threshold)
                        zeroCrossing(i,j)=1;
                end
            end
        end
    end
    for j=1:col-1
        for i=1:row-1
            if (LoGimage(i,j)>0 && LoGimage(i+1,j)<0)             % col[+,-]
                if (abs(LoGimage(i,j)+LoGimage(i+1,j))>threshold)
                    zeroCrossing(i,j)=1;
                end
            end
            if (LoGimage(i,j)<0 && LoGimage(i+1,j)>0)         % col[-,+]
                if (abs(LoGimage(i+1,j)+LoGimage(i,j))>threshold)
                    zeroCrossing(i,j)=1;
                end
            end
        end
    end
    
    disp('zeroCrossing:')
    disp(zeroCrossing)
return