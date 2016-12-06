function output_image = ro_filtjorge(image_file,order);

% Autor original: Antony Nelson.
% Modificaciones de esta versión: Jorge Márquez
%
% Esta rutina contiene las modificaciones indicadas en la sección de 
% Anexos del informe de trabajo de grado PROCESAMIENTO DE IMÁGENES DE 
% ANGIOGRAFÍA BIPLANA USANDO UNA TARJETA DE DESARROLLO SPARTAN-3E
% 
% UNIVERSIDAD DE LOS ANDES
% FACULTAD DE INGENIERÍA
% ESCUELA DE INGENIERÍA ELÉCTRICA
%
% Mérida, Septiembre, 2008

t=cputime;
input_image = imread(image_file); % loads image into input_image
[ylength,xlength] = size(input_image); % determines size of input image
output_image(1:ylength,1:xlength) = zeros; %inits output_image

% loops to simulate SE window passing over image
for y=1:ylength-2
    for x=1:xlength-2
        window = [input_image(y:(y+2),x:(x+2))];
        window_v = [[window(1,1:3)] [window(2,1:3)] [window(3,1:3)]];
        sorted_list = sort(window_v);
        output_image(y+1,x+1) = sorted_list(order);
    end
end

tfin=cputime-t;
%plots ro filtered image
figure;
image(output_image);
colormap(gray(256));
title('Rank Order Filter Output');
