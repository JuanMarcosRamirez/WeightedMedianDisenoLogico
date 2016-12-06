%Funci�n gif2mcs

%Autor: Jorge M�rquez

%Esta funci�n realiza la codificaci�n de una imagen en formato .gif a un
%archivo de texto plano con extensi�n .mcs
%El formato de dicho archivo es muy similar al formato Intel Hex
%ampliamente conocido.


%NOTA IMPORTANTE: Este algoritmo no ejecuta "cheksum". Esto debido a que
%fue dise�ado para transmitir le archivo a una aplicaci�n, en hardware, que no hac�a la comprobaci�n
%de este byte. Por esta raz�n, para cada columna de datos, el byte
%denominado "cheksum" fue configurado con el valor AAh para todas las
%l�neas de datos.

function gif2mcs

I = imread('lena128.gif ');                     %ojo camabiar cuando se cambie de tama�o de imagen
                                                %trabajo posterior:
                                                %Solicitar la direcci�n del
                                                %archivo
[ylength,xlength] = size(I);                    
ndir=(xlength*ylength);
K = double(I);
hexk=dec2hex(K);                                %Obtenci�n de los valores hexadecimales
                                                %(el resultado es una matriz de caracteres de 2 columnas.
                                                %cada fila representa un byte en notaci�n hexadecimal)
                                                
khexcell=cellstr(hexk);                         %Traslado de la matriz de caracteres a matriz tipo cell
khexreshape = reshape(khexcell,ylength,xlength);%redimensionamiento de la matriz a su forma original
                                                %(ahora en hexadecimal)
                                                
khexreshapet=khexreshape';                      %transposici�n de la matriz para que el siguiente redimensionamiento
                                                %conserve la concatenaci�n
                                                %de las filas
                                                
datost=reshape(khexreshapet,16,(ndir/16));      %redimensionamiento de la matriz (valores fila-columna intercambiados
                                                %previendo transposici�n siguiente)
                                                
datos=datost';                                  %transposici�n para obtener de nuevo el arreglo con las filas
                                                %concatenadas.


direcc =[0:16:(ndir-1)];                        %Generaci�n del vector fila de direcciones
direccionesdec=direcc';                         %Obtenci�n del vector columna de direcciones
direccioneshex=dec2hex(direccionesdec);         %Obtenci�n de los valores hexadecimales
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

ckecksumdec=65*ones(1024,2);                    %Generaci�n de la columna de bytes "cheksum"
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

