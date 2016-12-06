% Autor: Jorge M�rquez
%
% Esta funci�n reconvierte los datos en formato binario a forma
% gr�fica, con la posibilidad de escribirlos en un archivo en formato
% GIF (ver comentario al final de la rutina)
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

function imagen_reconstruida = binario2gifj_menos32_a_cero_512x512(archivo_bin);


fid = fopen(archivo_bin);
linea = fscanf(fid,'%c',inf);
linea=double(linea);
linea=linea-32;
for pos=1:512*512
    
    if linea(1,pos)==-32
        linea(pos)=0;
    end
    
end


I = reshape(linea,512,512);
imagen_reconstruida=uint8(I');
figure;
image(imagen_reconstruida);
title('imagen reconstruida de texto');
Cmap = gray(256);
Colormap(Cmap);

% para escribir la imagen en formato gif, col�quese un breakpoint luego de la 
% l�nea 35 y c�rrase la funci�n. Luego usar en la ventana de comandos la 
% funci�n imwrite.
% ej: imwrite(imagen_reconstruida,'C:\Documents and Settings\...\imagen','gif')



