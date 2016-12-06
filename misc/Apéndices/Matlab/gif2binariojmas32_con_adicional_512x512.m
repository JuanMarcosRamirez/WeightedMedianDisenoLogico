% Autor: Jorge M�rquez
%
% Esta funci�n extrae los datos de los p�xeles de una imagen en escala de
% grises de 256 valores, los almacena en una matriz y posteriormente los
% escribe en un archivo binario. Tambi�n se adiciona un offset de 32 a
% los datos binarios para poder ser transmitidos por el hyperterminal.
% (los primeros 32 caracteres del c�digo ISO-8859-1, o tambi�n conocido como 
% Latin 1, no son imprimibles)
%
% Esta rutina se encuentra tambi�n en la secci�n de 
% Ap�ndices del informe de trabajo de grado PROCESAMIENTO DE IM�GENES DE 
% ANGIOGRAF�A BIPLANA USANDO UNA TARJETA DE DESARROLLO SPARTAN-3E
% 
% UNIVERSIDAD DE LOS ANDES
% FACULTAD DE INGENIER�A
% ESCUELA DE INGENIER�A EL�CTRICA
% 
% M�rida, Septiembre, 2008
%

function [clinea] = gif2binariojmas32_con_adicional_512x512(archivogif,archivobinario);


I = imread(archivogif);
I=I';
linea = reshape(I,1,512*512);


linea=linea+32;
adicional=uint8(ones(1,512+17));
nuevalinea=[linea adicional];
clinea = char(nuevalinea);
dlmwrite(archivobinario, clinea, 'delimiter','');

