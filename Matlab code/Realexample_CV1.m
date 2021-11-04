%% Cross-validation program using program 1

clear all
clc
%% load adjacency matrix from real data 
Adj=textread('karate.txt');
SIZE = size(Adj,1);

%% Get the Evolutionary Game Data, Including the Strategies and Unity
b=1.2; % Define the game parameter
k=0.1; % Fermi parameter
    alpha=0.1;
    Length=0.3;
    %% Reconstruct the Network Structure Based on the Evolutionary Game Data
    [Stra,Unity] = GameUG(Adj);
    %get the data 
    [ y,Fai ] = get_data_ug( Stra,Unity,Length);
    SIZE = size(Stra,1);

% selecting lambda0 and lambda1
lambda1=[0.5:0.1:0.9];
lambda0=[1 1e-1 1e-2 1e-3 1e-4 1e-5 1e-6 1e-7];

 for k=1:length(lambda0)
     for i=1:length(lambda1)
     c0(k,i) = CV1(Fai,y,lambda0(k),lambda1(i),1-lambda1(i),SIZE);
     end
 end
 [lambda1' c0']
clear lambda0 lambda1 lambda2;
