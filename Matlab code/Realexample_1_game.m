%% Program for calculating the reconstruction of network in evolutionary UG game with application in Karate data
%% Using program 1
clear
clc

Adj=textread('karate.txt'); %Import the network data, Connection List
SIZE = size(Adj,1);% Get the Size of Adjacent Matrix

b=1.2; % Define the game parameter
k=0.1; % Fermi parameter
alpha=0.05;

    Length=0.3;
    [Stra,Unity] = GameUG(Adj);
    %get the data 
    [ y,Fai ] = get_data_ug( Stra,Unity,Length);
    SIZE = size(Stra,1);
    clear Stra Unity;
    
% Lasso estimator
    [b0,fitinfor]=lasso(Fai,y,'CV',5); %Default function of lasso in matlab
    Lam0=fitinfor.Lambda;
    index0=fitinfor.IndexMinMSE;
    B0=b0(:,index0);
    Adj_Re1=reshape(B0,SIZE,SIZE);
    clear Lam0 index0 b0 B0;
    [ SREL1,SRNL1,PRC1,MSE1 ] = AM ( Adj,Adj_Re1,alpha );
 
    
    %signal lasso estimator
    lambda0=1e-7;Lambda1=0.5; Lambda2=0.5;
    [Adj_Re2,xSIZE2] = Signal_Lasso_1(y,Fai,SIZE,Lambda1,Lambda2,lambda0);
    [ SREL2,SRNL2,PRC2,MSE2 ] = AM ( Adj,Adj_Re2,alpha ) ;
    
    % In order are True positive rate(SREL),True negative rate (SRNL),
    % Precision, and MSE respectively
    
    'Acurracy of reconstruction using Lasso method'
    [ SREL1,SRNL1,PRC1,MSE1 ]
    
    'Acurracy of reconstruction using signal lasso method'
    [ SREL2,SRNL2,PRC2,MSE2 ]




    