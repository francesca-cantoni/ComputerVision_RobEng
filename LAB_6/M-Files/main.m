%% MAIN function 

clear all, close all;
addpath('Mire');
addpath('Rubik');

% choose the desired inpunt data
% 1 --> to use Mire points and Mire images
% 2 --> to use Rubik points and Rubik images

input = 1;
 
if(input == 1)
    p1 = load("Mire1.points");
    p2 = load("Mire2.points");

    im_1 = imread("Mire1.pgm");
    im_2 = imread("Mire2.pgm");
    
elseif (input == 2)
    p1 = load("Rubik1.points");
    p2 = load("Rubik2.points");

    im_1 = imread("Rubik1.pgm");
    im_2 = imread("Rubik2.pgm");
end

%% Preliminary actions:
% Rewrite p1,p2 into homogeneous coordinates

dim_1=size(p1);
P1=[p1';ones(1,dim_1(1))];

dim_2=size(p2);
P2=[p2';ones(1,dim_2(1))];

%% VERSION 1: 8-points algorithm
% extimation of the fundamental matrix F1

F1 = EightPointsAlgorithm(P1, P2);


%% VERSION 2: 8-points algorithm normalized
% extimation of the fundamental matrix F2

F2 = EightPointsAlgorithmN(P1, P2);


%% Evaluation of the results
%% 1: Check epipolar contraint for all points

for i=1:dim_1(1)
    
    % version 1 --> fundamental matrix F1
    check_epip_constr(i,1) = P2(:,i)'*F1*P1(:,i);
    
    % versione 2 --> fundamental matrix F2 
    check_epip_constr(i,2) = P2(:,i)'*F2*P1(:,i);
end


%% 2: Visualization of the stereo pairs with epipolar lines of the corresponding points

fontSize=18;
figure, sgtitle('Epipolar lines','FontSize', fontSize);
subplot(2,1,1), visualizeEpipolarLines(im_1, im_2, F1, p1, p2), title('8-points algorithm');
subplot(2,1,2), visualizeEpipolarLines(im_1, im_2, F2, p1, p2), title('8-points algorithm normalized ');


%% 3: Consider the right and left epipole (respectively e and e')

% 8-point algorithm

    [U1, W1, V1] = svd(F1);
    
    % right epipole is the left annihilator of F1
    check_epipole(:,1) = (U1(:,end)'*F1)';
    
    % left epipole is the right annihilator of F1
    check_epipole(:,2) = F1*V1(:,end);

    disp("8-point algorithm");
    % right epipole coordinates
    disp("e': ");
    disp(U1(:,end));
    % left epipole coordinates
    disp("e: ");
    disp(V1(:,end));


% 8-points algorithm normalized

    [U2, W2, V2] = svd(F2);
    
    % right epipole is the left annihilator of F2
    check_epipole_norm(:,1) = (U2(:,end)'*F2)';
    
    % left epipole is the right annihilator of F2
    check_epipole_norm(:,2) = F2*V2(:,end);

    disp("8-point algorithm normalized");
    % right epipole coordinates
    disp("e: ");
    disp(U2(:,end));
    % left epipole coordinates
    disp("e': ");
    disp(V2(:,end));
