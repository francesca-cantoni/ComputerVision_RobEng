%% 8-points algorithm 
%% for the estimation of the fundamental matrix F1

function [F] = EightPointsAlgorithm(P1, P2)
    %% 1: write matrix A
    [row,col] = size(P1);
     N = col;
     
     A = [(P1(1,:).*P2(1,:))',(P1(2,:).*P2(1,:))',P2(1,:)',(P1(1,:).*P2(2,:))', ...
            (P1(2,:).*P2(2,:))',P2(2,:)',P1(1,:)',P1(2,:)',ones(N,1)];
    
    
    
    %% 2: estimation of the fundamental matrix F
    
    % compute the SVD of A
    [U, D, V]=svd(A);
    
    % select as solution f the last column of V 
    %(solution of the minimize problem)
    f = V(:,end);
    
    % f(column vector) --> reshape --> F (matrix 3x3)
    F = reshape(f,[3,3]);
    F = F';
    
    %% 3: force rank(F)=2 (non ideal case could be rank(F)=3)
    
    % compute SVD decomposition of F in order to define F' 
    %(quantity as much as possible closes to the estimated F but with det(F')=0)
    
    [U, D, V]=svd(F);
    
    % set D(3,3)=0 (ensure det(F')=0)
    D_new=D;
    D_new(3,3)=0;
    
    % compute F'=F
    F = U*D_new*V';
    
    
    
    
    
end