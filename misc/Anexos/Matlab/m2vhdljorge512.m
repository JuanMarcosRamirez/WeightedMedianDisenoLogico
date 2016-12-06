function M = m2vhdljorge512(input_gif,output_txt); % OJO CAMBIE A GIF y TXT

% Autor original: Antony Nelson.
% Modificaciones de esta versi�n: Jorge M�rquez
%
% Esta rutina contiene las modificaciones indicadas en la secci�n de 
% Anexos del informe de trabajo de grado PROCESAMIENTO DE IM�GENES DE 
% ANGIOGRAF�A BIPLANA USANDO UNA TARJETA DE DESARROLLO SPARTAN-3E
% 
% UNIVERSIDAD DE LOS ANDES
% FACULTAD DE INGENIER�A
% ESCUELA DE INGENIER�A EL�CTRICA
%
% M�rida, Septiembre, 2008

I = imread(input_gif) ; % OJO CAMBIE A GIF y funcion imload
%J = int16(I);
K = double(I);
K = K';
M = reshape(K,512*512,1);
fid = fopen(output_txt,'wb');
fprintf(fid,'%d\n',M);
fclose(fid);