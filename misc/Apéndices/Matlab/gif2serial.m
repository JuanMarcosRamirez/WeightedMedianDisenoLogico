% Autor: Jorge Márquez
% 
% Esta función convierte el archivo de imagen GIF a texto en forma serial.
% Cada linea del archivo final tendra unos o ceros correspondientes a cada
% bit a ser transmitido. Además se asocia un bit de inicio (en alto) y un
% bit de parada (en bajo) por cada byte convertido.

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

function gif2serial(archivogif,archivoserial);


I = imread(archivogif);
I=I';
linea = reshape(I,1,512*512);

lineat=linea';
bytes=dec2bin(lineat,8);

bit0=bytes(:,8);
bit1=bytes(:,7);
bit2=bytes(:,6);
bit3=bytes(:,5);
bit4=bytes(:,4);
bit5=bytes(:,3);
bit6=bytes(:,2);
bit7=bytes(:,1);

bytesinv=[bit0 bit1 bit2 bit3 bit4 bit5 bit6 bit7];

decunos=ones(262144,1);

dec48s=decunos*48;
bitini=char(dec48s);

dec49s=decunos*49;
bitpar=char(dec49s);

DatosconTR=[bitini,bytesinv,bitpar];
DatosconTRlinea=DatosconTR';
lineafinal=reshape(DatosconTRlinea,1,512*512*10);
iniciali=ones(1,10)*49;
lineafinal=[iniciali,lineafinal];
dlmwrite(archivoserial, lineafinal, 'delimiter','\n');

%fid = fopen(archivoserial,'wb'); se utilizó para los txt
%fprintf(fid,'%d\n',M);
%fclose(fid);