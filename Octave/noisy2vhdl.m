function I = noisy2vhdl(input_image,output_txt, density);
% filename: noisy2vhdl.m
% author:   Juan Marcos Ramirez
% date:     12/05/2016
% detail:   1) Carga una imagen limpia
%           2) Contamina la imagen con ruido sal y pimienta de densidad 
%             (density). 0 <= density <= 1.
%           3) Los datos de la imagen ruidosa se convierte a formato txt.        
% parameters: input_image - imagen a contaminar y convertir
%             output_txt - archivo de entrada del testbench vhdl
%             density - densidad del ruido sal y pimienta

% Leer Image
I = imread(input_image);
[rows,cols] = size(I);

% Contaminar Imagen
In = imnoise(I, "salt & pepper", density);
It = In';
M = reshape(It,rows*cols,1);

% Guardar en txt
fid = fopen(output_txt,'wb');
fprintf(fid,'%d\n',It);
fclose(fid);

figure;
subplot(121);
imshow(I,[]);
subplot(122);
imshow(In,[]);