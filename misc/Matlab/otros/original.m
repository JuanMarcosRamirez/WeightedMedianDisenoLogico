function [input_image] = original(image_file);
%plots ro filtered image
%input_image = imread('C:\Documents and Settings\Invitado.GPASS\Mis documentos\Jorge M�rquez\Tesis de grado\Presentaci�n 1\a color Lenna.png');
input_image = imread(image_file);
figure;
image(input_image)
colormap(gray(256));
title('Imagen Original');