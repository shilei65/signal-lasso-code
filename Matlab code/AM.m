function [ SREL,SRNL,PRC,MSE ] = AM ( Adj,Adj_Re,alpha )
% Function for computation of reconstruction accuracy
% SREL is success rate of existence link, SRNL is the success rate of existence link
% PCR is the precision rate, which is the fraction of correctly inferred links out of predicted signal links. 

N=size(Adj,1);
sum2=length(find(Adj==0));         
sum1=N*N-sum2;                     

TP=0;
TN=0;
FP=0;
for i=1:N
    for j=1:N
        if Adj_Re(i,j)<=1+alpha && Adj_Re(i,j)>=1-alpha
            Adj_Re(i,j)=1;
        elseif Adj_Re(i,j)<=alpha && Adj_Re(i,j)>=-alpha
            Adj_Re(i,j)=0;
        end
    end
end;

for i=1:N
    for j=1:N
        if Adj(i,j)==1 && Adj(i,j)==Adj_Re(i,j)
            TP=TP+1;
        elseif Adj(i,j)==0 && Adj(i,j)==Adj_Re(i,j)
            TN=TN+1;
        elseif Adj(i,j)==0 && Adj_Re(i,j)==1
            FP=FP+1;
        end
    end
end;

SREL=TP/sum1;
SRNL=TN/sum2;
PRC=TP/(TP+FP);
MSE=sum(sum((Adj-Adj_Re).*(Adj-Adj_Re)))/(N*N);
clear TP TN FP;
end

