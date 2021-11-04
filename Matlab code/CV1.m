function MSE = CV1(X,y,Lambda0,Lambda1,Lambda2,SIZE)
% conduct the cross validation process with
% using program 1

Ny                 = length(y);
Nsubject           = Ny/SIZE;% Number of subjects
XSIZE              = SIZE*SIZE;
k                  = 1:SIZE;
idTest             = Nsubject*k';
ytest              = y(idTest);
Xtest              = X(idTest,:);
yTrain             = y;
yTrain(idTest)     = [];
XTrain           = X;
XTrain(idTest,:) = [];

  
        [Adj,XSIZE]=Signal_Lasso_1(yTrain,XTrain,SIZE,Lambda1,Lambda2,Lambda0);
        x = reshape(Adj,SIZE*SIZE,1);
        MSE=sum((ytest-Xtest*x).^2)./length(ytest); 
clear beta idtest Xtest ytest k XSIZE yTrain XTrain;
end
