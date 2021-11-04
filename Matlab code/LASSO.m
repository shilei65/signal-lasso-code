% Function of LASSO code using cvx package

function [Adj,XSIZE]=LASSO(y,Fai,SIZE,lambda)
      XSIZE=SIZE*SIZE;
        cvx_begin
            variable x(SIZE*SIZE) nonnegative;
            minimize(lambda.*norm(x,1)+square_pos(norm(y-Fai*x,2)));        
        cvx_end
    Adj=reshape(x,SIZE,SIZE);
end

