% Autor: Jorge Márquez
%
% 
% Esta función extrae los datos de los píxeles de una imagen en escala de
% grises de 256 valores, los almacena en una matriz y posteriormente los
% escribe en un archivo binario.


function [clinea] = gif2binariojmas32_loopback_512x512(archivogif,archivobinario);


I = imread(archivogif);
I=I';
linea = reshape(I,1,512*512);

% for pos=1:512*512
%     
%     if linea(1,pos)==255
%         linea(pos)=255-32;
%     end
%     
% end

nuevalinea=linea+32;
%adicional=uint8(ones(1,512+17));
%nuevalinea=[linea adicional];
clinea = char(nuevalinea);
dlmwrite(archivobinario, clinea, 'delimiter','');

