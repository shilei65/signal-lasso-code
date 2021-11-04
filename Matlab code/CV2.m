function MSE = CV2(X,y,Lambda0,Lambda1,Lambda2,SIZE)
% conduct the cross validation process with
% using program 2
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

        cvx_begin
            variable x(SIZE*SIZE) nonnegative;
            minimize(Lambda0*(Lambda1*norm(x,1)+Lambda2*norm(x-1,1))+square_pos(norm(yTrain-XTrain*x,2)));
        cvx_end

        beta = x;
        MSE=sum((ytest-Xtest*beta).^2)./length(ytest); 
clear beta idtest Xtest ytest k XSIZE yTrain XTrain;
end
