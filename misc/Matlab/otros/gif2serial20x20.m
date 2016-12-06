function gif2serial20x20(archivogif,archivoserial);


I = imread(archivogif);
I=I';
linea = reshape(I,1,20*20);

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

decunos=ones(20*20,1);

dec48s=decunos*48;
bitini=char(dec48s);

dec49s=decunos*49;
bitpar=char(dec49s);

DatosconTR=[bitini,bytesinv,bitpar];
DatosconTRlinea=DatosconTR';
lineafinal=reshape(DatosconTRlinea,1,20*20*10);
iniciali=ones(1,10)*49;
lineafinal=[iniciali,lineafinal];
dlmwrite(archivoserial, lineafinal, 'delimiter','\n');

%fid = fopen(archivoserial,'wb'); se utilizó para los txt
%fprintf(fid,'%d\n',M);
%fclose(fid);