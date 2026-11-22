function MainProgram(dim,Lob,Upb)
%Function - MAIN FUNCTION FOR NUMERICAL TESTS 
%With this function can be obtained  Tables 1,2 and 3 in [1].
%PHD Jorge Barrios Ginart - Universidade Federal de Goiás 2015
%Version 17/06/2015 - This is the main file 
%References
%[1] J, Barrios, J.Y. Bello Cruz, O.P.Ferreira, S.Z. Németh. A semi-smooth Newton method for a special piecewise linear system with application to
%positively constrained convex quadratic programming.

% Initialize method parameters.
%///Parameters to change for each type of problem.


profile = 0;            %profile "on" 1, "off" 0.
ns =1;                  %number of solvers.
n   = dim;              %size of the problem. %input('Size of the problem \n'); sprintf('Size of the problem %d',n);
np   = 1000;            %number of problems.
nIP   = 1;              %number of initial points.       
tola  = -6;             %tolerance exponent a.
step  =-2;              %step between a and b
tolb  = -10;            %tolerance exponent b for solve problems from tol=10^tola to 10^tolb.
bMat = 1000000;         %bound for random values.
mIt  = 15;             %maximum accepted number of iterations.
coef = 1;               %coeficient.
repit= 1;              %number of simulations for each problem.

%///Fixed Parameters
cN   = 1000;            %maximum accepted condition number for A.
e1   = 1.0e-15;         %auxiliary perturbation 1 used in the calculation of b.
e2   = 1.0e-16;         %auxiliary perturbation 2 used in the calculation of bC.
upb  = Upb;             %upper bound for b.
lob  = Lob;             %lower bound for b.
lobbC = Lob;            %lower bound for bC.
I    = eye(n);          %N-by-N identity matrix.



if profile == 1
%///Parameters for P. Profile 
lineWidthProfile=3;
legendProfile={'IntPoint' ; 'Newton'}; % ;'Inexato2'};
titleProfile='title';
xlabelProfile='x';
ylabelProfile='y';
end


%%%%%%%%%%%%%SECTION: GENERATING TEST PROBLEMS%%%%%%%%%%%%%%%%%%%%%
%---COMMENT THIS SECTION if you do not need to generate new test examples----%%
for i=1:np     
cD = Inf;
Q =zeros(n);
mIP=zeros(n,nIP);
        while cD>cN
            b    = (lob+e1)+(upb-lob-2*e1)*rand;    %parameter b randomly fixed in (lob,upb).
            bC   = (lobbC+e2)+(b-lobbC-2*e2)*rand;  %parameter bC randomly fixed in (lobbC,b).
            X    = -bMat + (2*bMat).*rand(n);       %random matrix. 
            [S V D] = svd(X);                       %SVD of the random matrix.
            
            %the condition norm(Q-I) < upb is fulfilled.
            X    = S*(sqrt(coef*I+bC*(V/V(1,1))))*D;  
            Q = X'*X;
            cD=cond(X);
        end %while cD>cN.   

%generate solution u.
u  =-bMat + (2*bMat).*rand(n,1);  
%compute z "is ˜b in [1] eq (2)".
z  = -((Q-I)*max(u,0)+u);  

%generate the initials points.
        for q=1:nIP  
            mIP(:,q) = -bMat + (2*bMat).*rand(n,1);
        end  %for q=1:nIP 
setProbQ(Q,mIP,z,u,i,n,upb);
end %for i=1:np
%%%%%%%%%%%%%%%END SECTION: GENERATING TEST PROBLEMS%%%%%%%%%%%%%%%%%%%%%%


ex=tola:step:tolb;
[~, c]=size(ex);

for iex=1:c    
    tol  = 10^ex(iex);    
    sprintf('Tol %0.5g',tol)    
    time = zeros(repit,ns);
    tps  = zeros(np,ns);
    ips  = zeros(np,ns);
    sdtps  = zeros(np,ns);
    sdips  = zeros(np,ns);
    tpsIP  = zeros(nIP,ns);
    ipsIP  = zeros(nIP,ns);
    
    auxtps =zeros(np,1);
    auxips =zeros(np,1);
    auxsdtps =zeros(np,1);
    auxsdips =zeros(np,1);
    auxtps2=zeros(1,ns);
    auxips2=zeros(1,ns);
    auxsdtps2=zeros(1,ns);
    auxsdips2=zeros(1,ns);    
    
    stats1 = zeros(np,ns); %statistics for the number of problems for which the solver s did not converge.
    
    for i=1:np     
    [Q mIP z u] = getProbQ(i,n,nIP,upb); 
    
    %sprintf('Problem %d',i)     
        for j=1:nIP
            for k=1:repit 
                [ipsIP(j,1),time(k,1),~,~]=ssNewtonQ(n,Q,mIP(:,j),z,tol,mIt,u,i,j);
            end %for k=1:repit.  
            tpsIP(j,:)=median(time,1); %for each initial point take the median of time.      
        end %for k=1:repit        
        tps(i,:)=mean(tpsIP,1);    %problems time with each solver.
        ips(i,:)=mean(ipsIP,1);    %problems iterations with each solver.
        sdtps(i,:)=std(tpsIP,0,1); %Standard Deviation of times for every problem with every solver depending on the initial points.
        sdips(i,:)=std(ipsIP,0,1); %Standard Deviation of iterations for every problem with every solver depending on the initial points.
        
        pos1=find(tps(i,:)==Inf);
        stats1(i,pos1)=1;   
    end %for i=1:np
    
    namePictureProfile=strcat('Profile_n',num2str(n),'_np',num2str(np),'_exp',num2str(ex(iex)));
    
    if profile == 1
    pprofile(np,ns,tps,namePictureProfile,lineWidthProfile,legendProfile,titleProfile,xlabelProfile,ylabelProfile)
    end


    for y=1:ns
        auxtps=tps(:,y);
        auxips =ips(:,y);
        auxsdtps =sdtps(:,y);
        auxsdips =sdips(:,y);
        auxtps2(y)= mean(auxtps((auxtps>0)&(auxtps<Inf)),1);  
        auxips2(y) = mean(auxips((auxips>0)&(auxips<Inf)),1); 
        auxsdtps2(y) = mean(auxsdtps((auxsdtps>=0)&(auxsdtps<Inf)),1); 
        auxsdips2(y) = mean(auxsdips((auxsdips>=0)&(auxsdips<Inf)),1);    
    end 

    
    disp(namePictureProfile)
    disp('<<<<<Main-Statistics>>>>>')
    disp('mean times and mean sdt of times for each solver:')
    disp(auxtps2)
    disp(auxsdtps2)
    disp('mean of iterations and mean sdt of iterations for each solver:')
    disp(auxips2)
    disp(auxsdips2)
    disp('Number of problems that solver s did not converge:')
    disp(sum(stats1))


end %for exp=tola:step:tolb              

% if input('Do you want to delete all data yes 1 not 0 \n')
%     delete('*.bin')
% end

clear all
end