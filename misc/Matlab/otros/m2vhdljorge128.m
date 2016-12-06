function m2vhdljorge128(input_gif,output_bin); % OJO CAMBIE A GIF

% filename: m2vhdl.m
% author: Tony Nelson
% date: 1/21/00
% detail: a program to output a specified image to a stream of
% integers for VHDL file input
%
% parameters: input_bmp - file to convert to bin format
% output_bin - file ready for vhdl file input

I = imread(input_gif) ; % OJO CAMBIE A GIF y funcion imload
%J = int16(I);
K = double(I);
K = K';
M = reshape(K,128*128,1);
fid = fopen(output_bin,'wb');
fprintf(fid,'%d\n',M);
fclose(fid);