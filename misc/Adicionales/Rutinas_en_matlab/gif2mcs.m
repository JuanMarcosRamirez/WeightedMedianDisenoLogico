%Función gif2mcs

%Autor: Jorge Márquez

%Esta función realiza la codificación de una imagen en formato .gif a un
%archivo de texto plano con extensión .mcs
%El formato de dicho archivo es muy similar al formato Intel Hex
%ampliamente conocido.


%NOTA IMPORTANTE: Este algoritmo no ejecuta "cheksum". Esto debido a que
%fue diseñado para transmitir le archivo a una aplicación, en hardware, que no hacía la comprobación
%de este byte. Por esta razón, para cada columna de datos, el byte
%denominado "cheksum" fue configurado con el valor AAh para todas las
%líneas de datos.

function gif2mcs

I = imread('lena128.gif ');                     %ojo camabiar cuando se cambie de tamaño de imagen
                                                %trabajo posterior:
                                                %Solicitar la dirección del
                                                %archivo
[ylength,xlength] = size(I);                    
ndir=(xlength*ylength);
K = double(I);
hexk=dec2hex(K);                                %Obtención de los valores hexadecimales
                                                %(el resultado es una matriz de caracteres de 2 columnas.
                                                %cada fila representa un byte en notación hexadecimal)
                                                
khexcell=cellstr(hexk);                         %Traslado de la matriz de caracteres a matriz tipo cell
khexreshape = reshape(khexcell,ylength,xlength);%redimensionamiento de la matriz a su forma original
                                                %(ahora en hexadecimal)
                                                
khexreshapet=khexreshape';                      %transposición de la matriz para que el siguiente redimensionamiento
                                                %conserve la concatenación
                                                %de las filas
                                                
datost=reshape(khexreshapet,16,(ndir/16));      %redimensionamiento de la matriz (valores fila-columna intercambiados
                                                %previendo transposición siguiente)
                                                
datos=datost';                                  %transposición para obtener de nuevo el arreglo con las filas
                                                %concatenadas.


direcc =[0:16:(ndir-1)];                        %Generación del vector fila de direcciones
direccionesdec=direcc';                         %Obtención del vector columna de direcciones
direccioneshex=dec2hex(direccionesdec);         %Obtención de los valores hexadecimales
direcciones=cellstr(direccioneshex);            %Traslado de la matriz de caracteres a matriz tipo cell

recordtypedec= 48*ones(1024,2);
recordtypechar= char(recordtypedec);
recordtype= cellstr(recordtypechar);

bytecountdec=10*ones(1024,1);
bytecountchar=int2str(bytecountdec);
bytecount=cellstr(bytecountchar);

comlineadec=58*ones(1024,1);
comlineachar=char(comlineadec);
comlinea=cellstr(comlineachar);

ckecksumdec=65*ones(1024,2);                    %Generación de la columna de bytes "cheksum"
ckecksumchar=char(ckecksumdec);                 
ckecksum=cellstr(ckecksumchar);

lineasdatos=[comlinea bytecount direcciones recordtype datos ckecksum];

%desde el 02/04/08 en lab

%construccion linea inicial
lineainichar=(':020000040000FA');
lineaini=cellstr(lineainichar);
%construccion linea final

lineafinchar=(':00000001FF')
lineafin=cellstr(lineafinchar);

dlmwrite('lena128.mcs', lineaini, 'delimiter', '', 'newline', 'pc');%tuve problemas con esto en el lab
dlmwrite('lena128.mcs', lineasdatos, '-append', 'delimiter', '', 'newline', 'pc');
dlmwrite('lena128.mcs', lineafin, '-append', 'delimiter', '', 'newline', 'pc');

