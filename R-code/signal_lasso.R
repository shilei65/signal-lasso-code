library(glmnet)
library(MASS)
library(lars)
library(Rcpp)


#####Spefify the path of C-code
Rcpp::sourceCpp("/Users/mac/Desktop/New signal lasso method/R for signal lasso/signal_lasso.cpp")

#####the signal_lasso function####
SIGNAL_l=function(Y,X,beta0,lambda1,lambda2,constant=TRUE,iter_max,delta){
  #Y: the response vector
  #X: the covariate matrix
  #beta0: initial value of the estimated parameter
  #lambda1: the first penalty parameter
  #lambda2: the second penalty parameter
  #iter_max: the maximal iterations
  #delta: control the accuracy 
  p=ncol(X)
  Re2=numeric(p)
  for (i in 1:p) {
    Re2[i]=t(X[,i])%*%X[,i]  
  } 
  ep1=(lambda1+lambda2)/Re2
  ep2=(lambda1-lambda2)/Re2
  con=1*constant
  ptm=proc.time()
  fit.c=Signal_c(Y=Y, X=X, beta0=beta0, Re2=Re2, 
                 ep1=ep1, ep2=ep2,constant=con, iter_max=iter_max, p=p, delta=delta)
  return(list(Mu=fit.c$Mu,Beta=fit.c$Beta, Iter=fit.c$iters,Times=proc.time()-ptm))
}

#######The CV function for signal lasso####
CV.SIGNAL=function(Y,X,beta0,nfolds,nlambda1,alpha=c(seq(0.1,0.9,by=0.1),1/seq(0.1,0.9,by=0.1)),constant=TRUE,iter_max,delta){
  n=length(Y)

  folds=cv.folds(n,nfolds)
  
  re=NULL
  lambda3=NULL
  for (lambda2 in nlambda1) {
    for (j in alpha) {
      se=0
      lambda1=j*lambda2
      for (k in 1:nfolds) {
        Y1=Y[as.vector(unlist(folds[-k]))]
        X1=X[as.vector(unlist(folds[-k])),]
        Y2=Y[as.vector(unlist(folds[k]))]
        X2=X[as.vector(unlist(folds[k])),]
        fit=SIGNAL_l(Y=Y1,X=X1,beta0=beta0,lambda1,lambda2,constant=constant,iter_max,delta)
        se=se+mean((Y2-fit$Mu-X2%*%fit$Beta)^2)
      }
      re=c(re,se)
      lambda3=rbind(lambda3,c(lambda1,lambda2))
    }
  }
  index=which.min(re)
  return(list(lambda.1se=lambda3[index,],Re=re))   
}



####example##
###data generation
Tpm=function(p,rho){
  A=matrix(0,p,p)
  for (i in 1:p) {
    for (j in 1:p) {
      if(i==j){A[i,j]=1}
      else{A[i,j]=rho^(abs(i-j))}
    }
    
  }
  return(A)
}


p=10
p1=6
n=100
beta=c(rep(1,p1),rep(0,p-p1))
### Calculation based on k=100 simulations
k=100
beta.s=TPR.s=TNR.s=PCR.s=NULL  ##signal lasso
for(t in 1:k){
X=mvrnorm(n,rep(0,p),Tpm(p,0.5))
Y=X%*%beta+rnorm(n,0,0.2)
####initial beta0
cvfit=cv.glmnet(x=X,y=Y,intercept=FALSE,type.measure = "mse")
lar1=glmnet(x=X,y=Y,
            lambda =cvfit$lambda.1se,alpha = 1,intercept = FALSE)
beta0=coef.glmnet(lar1)[-1]

###CV and fit###
fit1=CV.SIGNAL(Y=Y,X=X,beta0 = beta0,nfolds=5,nlambda1=cvfit$lambda[1:10],
              alpha=c(seq(0.1,0.9,0.1),1/seq(0.1,0.9,0.1)), 
              constant=TRUE,iter_max = 2000,delta=1e-7)

fit.s=SIGNAL_l(Y=Y,X=X,beta0 = beta0, iter_max = 2000,
               lambda1=fit1$lambda.1se[1],lambda2 =fit1$lambda.1se[2],delta=1e-7)
beta1=fit.s$Beta
beta.s=rbind(beta.s, beta1)
signal.1=1*I(beta1>0.95 & beta1<1.05)
signal.0=1*I(beta1>-0.05 & beta1<0.05)
TPR.s=c(TPR.s,sum(signal.1[1:p1])/p1)
TNR.s=c(TNR.s,sum(signal.0[(p1+1):p])/(p-p1))
PCR.s=c(PCR.s,sum(signal.1[1:p1])/sum(signal.1))
print(t)
}
PCR.s[which(is.na(PCR.s))]=0
Mse=mean((colMeans(beta.s)-beta)^2)+mean(apply(beta.s, 2, var))
TPR=mean(TPR.s)
TNR=mean(TNR.s)
PCR=mean(PCR.s)

##Output of fitting accuracy
Mse
TPR
TNR
PCR