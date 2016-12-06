function I = vhdl2mjorge512(input_bin);

% Autor original: Antony Nelson.
% Modificaciones de esta versión: Jorge Márquez
%
% Esta rutina contiene las modificaciones indicadas en la sección de 
% Anexos del informe de trabajo de grado PROCESAMIENTO DE IMÁGENES DE 
% ANGIOGRAFÍA BIPLANA USANDO UNA TARJETA DE DESARROLLO SPARTAN-3E
% 
% UNIVERSIDAD DE LOS ANDES
% FACULTAD DE INGENIERÍA
% ESCUELA DE INGENIERÍA ELÉCTRICA
%
% Mérida, Septiembre, 2008

fid = fopen(input_bin);
[I,cnt] = fscanf(fid,'%d',inf);
fclose(fid);
I = reshape(I,512,512);
I = I';
%originalI = LoadImage('d:/usr/nelson/courses/aip/elaine_128x128.bmp');
%J = int16(originalI);
%originalI = double(J);
figure;
image(I);%ojo quite sc
title(input_bin);
Cmap = gray(256);
Colormap(Cmap);