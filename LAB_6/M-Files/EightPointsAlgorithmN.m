% extimation of the fundamental matrix F
%(with this approach F is invariant to point transformations)

function [F] = EightPointsAlgorithmN(P1, P2)

    %% 1: normalization of the sets of points P1 and P2 
    [nP1, T1] = normalise2dpts(P1);
    [nP2, T2] = normalise2dpts(P2);
    
    %% 2: estimation of F using as input the normalized values 
    F = EightPointsAlgorithm(nP1, nP2);
    
    %% 3: de-normalization of F
    F =  T2'*F*T1;
    
end
