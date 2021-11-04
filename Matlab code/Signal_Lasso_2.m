% function of signal lasso method using cvx package
% Output is adjacency matrix of network

function [Adj,XSIZE]=Signal_Lasso_2(y,Fai,SIZE,Lambda1,Lambda2,Lambda0)
    XSIZE=SIZE*SIZE;
        cvx_begin
            variable x(SIZE*SIZE) nonnegative;
            minimize(Lambda0*(Lambda1*norm(x,1)+Lambda2*norm(x-1,1))+square_pos(norm(y-Fai*x,2)));
        cvx_end
    Adj=reshape(x,SIZE,SIZE);
    clear x;
end

