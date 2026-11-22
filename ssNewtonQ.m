function [iter time er xk]=ssNewtonQ(n,Q,x0,z,TolX,mIt,u,npi,nIPi)
%Semi-smooth Newton method (22) from [1].
%PHD Jorge Barrios Ginart - Universidade Federal de Goiás 2015
%Version 17/06/2015 
%References
%[1] J, Barrios, J.Y. Bello Cruz, O.P.Ferreira, S.Z. Németh. A semi-smooth Newton method for a special piecewise linear system with application to
%positively constrained convex quadratic programming.

xk   = x0;
I    = eye(n);
iter = 0;
er   = norm(u-xk);
den  = 1+norm(u);

tic;
aux1=Q-I;

while er >= TolX*den
    iter=iter+1;
    if iter <= mIt
        xk1=-(aux1*diag(sign(max(xk,0)))+I)\z;        
       er = norm(u-xk1);
       if isnan(norm(u-xk1)/den)
         warning('MATLAB:ssNewtonQ', 'MATLAB:ssNewton:Diverge for problem %d initial point %d.',npi,nIPi);
         er=Inf;
         time=Inf;
         iter=Inf;
         return
       end
    else
        warning('MATLAB:ssNewtonQ', 'MATLAB:ssNewton:Maximum number of iterations reached for problem %d initial point %d.',npi,nIPi);
        er=Inf;
        time=Inf;
        iter=Inf;
        return
    end
    xk=xk1;
end
time=toc;

if iter == 0
    time = 0;
    warning('MATLAB:ssNewtonQ', 'MATLAB:ssNewton:x0 is the solution for problem %d initial point %d.',npi,nIPi);
end
end
