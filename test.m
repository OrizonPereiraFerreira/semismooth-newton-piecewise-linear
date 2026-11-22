% diary Simulacion2000
% clear all
% clc
% MainProgram(2000,0,0.5)
% diary off
% 
% diary Simulacion3000
% clear all
% clc
% MainProgram(3000,0,0.5)
% diary off
% 
% diary Simulacion4000
% clear all
% clc
% MainProgram(4000,0,0.5)
% diary off
% 
% diary Simulacion5000
% clear all
% clc
% MainProgram(5000,0,0.5)
% diary off

% 
diary SimulacionBVarible
%call to function
ante=0.5;
for coef=[1000 10000 100000 1000000 10000000 100000000]
    sprintf('De %d a %d',ante,coef) 
    MainProgram(1000,ante,coef)
    ante=coef;
end   
diary off