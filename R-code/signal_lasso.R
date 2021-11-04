library(glmnet)
library(MASS)
library(igraph)

#####the signal_lasso function####
Rcpp::sourceCpp("signal_lasso.cpp")
SIGNAL_l=function(Y,X,beta0,lambda1,lambda2,iter_max,delta){
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
  ptm=proc.time()
  fit.c=Signal_c(Y=Y, X=X, beta0=beta0, Re2=Re2, 
                 ep1=ep1, ep2=ep2, iter_max=iter_max, p=p, delta=delta)
  return(list(Beta=fit.c$Beta, Iter=fit.c$iters,Times=proc.time()-ptm))
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

p=100
n=50
beta=sample(c(0,1),size = p,replace =T,prob = c(0.9,0.1))
X=mvrnorm(n,rep(0,p),Tpm(p,0.5))
Y=X%*%beta+rnorm(n,0,0.1)
####initial beta0
cvfit=cv.glmnet(x=X,y=Y,intercept=FALSE,type.measure = "mse")
lar1=glmnet(x=X,y=Y,
            lambda =cvfit$lambda.1se,alpha = 1,intercept = FALSE)
beta0=coef.glmnet(lar1)[-1]
###fit###
fit.s=SIGNAL_l(Y=Y,X=X,beta0 = beta0, iter_max = 2000,
               lambda1=100*cvfit$lambda.1se,lambda2 =10*cvfit$lambda.1se,delta=1e-7)
fit.s
