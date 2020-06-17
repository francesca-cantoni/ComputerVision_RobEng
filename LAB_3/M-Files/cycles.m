%% set the parameters of cycles(INimage,mainLoop,row,sig,sigstep,coeff,coeffstep,th,thstep)
% INimage -> input image on which it will be performed edge detection 
%             operation
% mainLoop -> number of subplot displayed maintaining the values of sigma and 
%             spatial dimension unchanged , and varying just the threshold 
%             value at each iteration 
% row -> # of row in each subplot 
% sig -> value of sigma related to the LoG operator
% sigstep -> increment value of sigma added to the previous one after 
%           mainloop iterations
% coeff -> value that influences the dimension of the spatial support
%          REMARK: is better to mantain this value greater or
%                  equal to 3
% th -> threshold value using inside zeroCrossing() function
% thstep -> increment value of the threshold added to the previous one at each 
%           iteration of edgedetect() function

function cycles(INimage,mainLoop,row,sig,sigstep,coeff,th,thstep)
    
% k -> number of parameters that we want to change
    % mainLoop -> number of iterations mantaining constant the value
    % num_loop -> number of iteration for a single parameter 
    % count -> number of iteration in which it is changes only the 
    %          the threshold
    
    k=3;            
    num_loop = mainLoop*k;        
    count=1;
    th_init=th;
    
    for i=1:num_loop
        edgedetection(INimage,sig,coeff,th,thstep,row)
        th=th+thstep*count*row;
        if (count==mainLoop)
             th=th_init;
             sig=sig+sigstep;
             count=0;
        end
        count=count+1;
    end
end