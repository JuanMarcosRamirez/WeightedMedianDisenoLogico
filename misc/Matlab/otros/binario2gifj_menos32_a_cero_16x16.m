function imagen_reconstruida = binario2gifj_menos32_a_cero_16x16(archivo_bin);


fid = fopen(archivo_bin);
linea = fscanf(fid,'%c',inf);
linea=double(linea);
linea=linea-32;
for pos=1:16*16
    
    if linea(1,pos)==-32
        linea(pos)=0;
    end
    
end

% for pos=1:512*512
%     
%     if linea(1,pos)==223
%         linea(pos)=255;
%     end
%     
% end %este lazo es necesario s�lo para los loopbacks

% lineaa=linea(1,1:262144);
% linea4b=linea3(1,155808:261121);% valor l�mite anterior 262146
% linea4=[linea4a linea4b];
% linea4=linea4(1,1:261120);% valor l�mite anterior 262144
%linea4 = dlmread('lenacaracter512.txt','') no funcion� porque dlmread no
%lee sino datos num�ricos en ascii

%linea2= textread('lenacaracter512.txt','%c') no funcion� porque no
%reconoce bi�n los caracteres, inclusive usando slCharacterEncoding('ISO
%8859-1')

%linea3 = fscanf(fid,'%s',inf) no funcion� por quitar algunos espacios
I = reshape(linea,16,16);% ojo para la linea faltante colocar 512,510
imagen_reconstruida=uint8(I');
figure;
image(imagen_reconstruida);
title('imagen reconstruida de texto');
Cmap = gray(256);
Colormap(Cmap);

% ej: imwrite(I,'C:\Documents and Settings\...\imagen','gif')



