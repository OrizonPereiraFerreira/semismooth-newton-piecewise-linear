function setProbQ(Q,mIP,z,u,i,n,upb)
%Function for writing a test problem.
%PHD Jorge Barrios Ginart - Universidade Federal de Goiás 2015
%Version 17/06/2015  

% Create the file Qi.bin with the matrix A of problem i
fid = fopen(strcat('Q',num2str(n),'_',num2str(i),'_',num2str(upb),'.bin'), 'w');
fwrite(fid, Q,'double');
fclose(fid);
% Create the file mIPi.bin with the matrix A of problem i
fid = fopen(strcat('mIP',num2str(n),'_',num2str(i),'_',num2str(upb),'.bin'), 'w');
fwrite(fid, mIP,'double');
fclose(fid);
% Create the file zi.bin with the matrix A of problem i
fid = fopen(strcat('z',num2str(n),'_',num2str(i),'_',num2str(upb),'.bin'), 'w');
fwrite(fid, z,'double');
fclose(fid);
% Create the file ui.bin with the matrix A of problem i
fid = fopen(strcat('u',num2str(n),'_',num2str(i),'_',num2str(upb),'.bin'), 'w');
fwrite(fid, u,'double');
fclose(fid);
end
