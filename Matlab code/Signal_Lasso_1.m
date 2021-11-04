
function [Adj,XSIZE]=Signal_Lasso_1(y,X,SIZE,lambda1,lambda2,lambda0)
%% Functiof for calculating the signal lasso estimation of regression coefficients 
%% using the coordinate descent method-program 1
% The linear regression model is Y=X*beta+e

[n,p]=size(X);
ds=1; 

% initilize beta with lasso estimator
 [b0,fitinfor]=lasso(X,y,'CV',5); %default code of lasso in matlab
    Lam0=fitinfor.Lambda;
    index0=fitinfor.IndexMinMSE;
    B0=b0(:,index0);  
  clear Lam0 index0 b0;
  
% iterative calculation of signal lasso using the coordinate descent method
B=zeros(p,1);
 xxk = sum(X.^2, 1)';
    delta1 = lambda0.*(lambda1 + lambda2)./xxk;
    delta2 = lambda0.*(lambda1 - lambda2)./xxk;
inumb=1;
while ds >= 1e-11 && inumb < 50
    BB0=B0;
   for k=1:p
        ds0=1;inumb0=1;
       while ds0>=1e-8 && inumb0 < 100
         beta_t=BB0(k)+X(:,k)'*(y-X*BB0)./xxk(k);
         B(k)=max(0,thresholdfunc(beta_t,delta1(k),delta2(k)));
         B(k)=min(1,B(k));
         ds0=abs(B(k)-BB0(k))./(1+abs(BB0(k)));
         inumb0=inumb0+1;
         BB0(k)=B(k);
       end
       clear beta_t inumb0;
    end
    ds=max(abs(B-B0) ./ (1.0 + abs(B0)));
    inumb=inumb+1;
    B0=B;
end
 XSIZE=SIZE*SIZE;
 Adj=reshape(B,SIZE,SIZE);
clear delta1 delta2 B0 ds inumb;
end

