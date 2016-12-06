% Autor: Jorge Márquez
%
% Esta función reconvierte los datos en formato binario a forma
% gráfica, con la posibilidad de escribirlos en un archivo en formato
% GIF (ver comentario al final de la rutina)
%
% Esta rutina se encuentra también en la sección de 
% Apéndices del informe de trabajo de grado PROCESAMIENTO DE IMÁGENES DE 
% ANGIOGRAFÍA BIPLANA USANDO UNA TARJETA DE DESARROLLO SPARTAN-3E
% 
% UNIVERSIDAD DE LOS ANDES
% FACULTAD DE INGENIERÍA
% ESCUELA DE INGENIERÍA ELÉCTRICA
% 
% Mérida, Septiembre, 2008
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

% para escribir la imagen en formato gif, colóquese un breakpoint luego de la 
% línea 35 y córrase la función. Luego usar en la ventana de comandos la 
% función imwrite.
% ej: imwrite(imagen_reconstruida,'C:\Documents and Settings\...\imagen','gif')



