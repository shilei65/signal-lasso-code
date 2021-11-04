%% Program for calculating the reconstruction of network in evolutionary UG game with application in Karate data
%% Using cvx pakage (program 2)

clear
clc

Adj=textread('karate.txt'); %Import the network data, Connection List
SIZE = size(Adj,1);% Get the Size of Adjacent Matrix

b=1.2; % Define the game parameter
k=0.1; % Fermi parameter
alpha=0.05;

    Length=0.5;
    [Stra,Unity] = GameUG(Adj);
    %get the data 
    [ y,Fai ] = get_data_ug( Stra,Unity,Length);
   
    % Lasso estimator
    SIZE = size(Stra,1);
    clear Stra Unity;
    lambda0=1e-5;
    [Adj_Re1,xSIZE] = LASSO(y,Fai,SIZE,lambda0);
    [ TPR1,TNR1,PRC1,MSE1 ] = AM ( Adj,Adj_Re1,alpha );
 
    
    %signal lasso estimator
    lambda0=1e-7;Lambda1=0.5; Lambda2=0.5;
    [Adj_Re2,xSIZE2] = Signal_Lasso_2(y,Fai,SIZE,Lambda1,Lambda2,lambda0);
    [ TPR2,TNR2,PRC2,MSE2 ] = AM ( Adj,Adj_Re2,alpha ) ;
    
    % In order are True positive rate(SREL),True negative rate (SRNL),
    % Precision, and MSE respectively
    
    'Acurracy of reconstruction using Lasso method'
    [ TPR1,TNR1,PRC1,MSE1 ]
    
    'Acurracy of reconstruction using signal lasso method'
    [ TPR2,TNR2,PRC2,MSE2 ]




    