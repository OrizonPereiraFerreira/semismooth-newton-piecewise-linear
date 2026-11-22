function [Q mIP z u] = getProbQ(i,n,nIP,upb)
%Function to read a test problem.
%PHD Jorge Barrios Ginart - Universidade Federal de Goiás 2015
%Version 17/06/2015 

% Read the file Q.bin with the matrix A of problem i
fid = fopen(strcat('Q',num2str(n),'_',num2str(i),'_',num2str(upb),'.bin'));
Q=fread(fid, [n,n],'double');
fclose(fid);
% Read the file mIPi.bin with the matrix A of problem i
fid = fopen(strcat('mIP',num2str(n),'_',num2str(i),'_',num2str(upb),'.bin'));
mIP=fread(fid, [n,nIP],'double');
fclose(fid);
% Read the file zi.bin with the matrix A of problem i
fid = fopen(strcat('z',num2str(n),'_',num2str(i),'_',num2str(upb),'.bin'));
z=fread(fid, [n, 1],'double');
fclose(fid);
% Read the file ui.bin with the matrix A of problem i
fid = fopen(strcat('u',num2str(n),'_',num2str(i),'_',num2str(upb),'.bin'));
u=fread(fid, [n, 1],'double');
fclose(fid);
end