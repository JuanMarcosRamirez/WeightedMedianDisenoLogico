function I = vhdl2mjorge128(input_bin);
% filename: vhdl2m.m
% author: Tony Nelson
% date: 1/21/00
% detail: a program to read in the VHDL output file
%
% paramter: input_bin - vhdl output bin file
%
%close all;
fid = fopen(input_bin);
[I,cnt] = fscanf(fid,'%d',inf);
fclose(fid);
I = reshape(I,128,128);
I = I';
%originalI = LoadImage('d:/usr/nelson/courses/aip/elaine_128x128.bmp');
%J = int16(originalI);
%originalI = double(J);
figure;
image(I);
title(input_bin);
Cmap = gray(256);
Colormap(Cmap);