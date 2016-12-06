function recepcionlena128_a_dec;

[fid,message] = fopen('recepcion_lena128.TXT');     %apertura del archivo
[A] = textread('recepcion_lena128.TXT','%s');       %lectura del texto
dd=hex2dec(A);                                      %conversi�n a decimal: resulta un vector columna
dd2 = reshape(dd,17,1024);                          %redimensionamiento de la matriz
                                                    %(en orden invertido, para poder conservar la filas)

dd3=dd2';                                           %transposici�n de la matriz


%martes 2 de abril de 2008


dd3(:,1)=[];                                        %eliminaci�n de la columna que contiene las direcciones en dd3
dd4=reshape(dd3',128,128);                          %redimensionamiento de la matriz dd3 transpuesta
imagen=dd4';                                       %transposici�n de la matriz resultado

figure;                                            %generaci�n de la ventana

%imagesc(imagen);                                  %ver si sustituir por funci�n image
                                                   %(se encuentra aplicada en vhdl2m)

image(imagen);                                     %graficaci�n de la imagen
title('Imagen de salida');                         
Colormap(gray(256));

