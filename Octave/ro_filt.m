function output_image = ro_filt(image_file,order);
%
% filename: ro_filt.m
% author: Tony Nelson
% date: 1/11/00
% Modified by: Juan Marcos Ramirez
% date: 04/12/2016
% detail: performs basic x3 rank order filtering
%
input_image = imread(image_file); % loads image into input_image
input_image = imnoise(input_image, "salt & pepper", 0.1);
[ylength,xlength] = size(input_image); % determines size of input image
noisy_image = imnoise(input_image, "salt & pepper", 0.1);
output_image(1:ylength,1:xlength) = zeros; %inits output_image

% loops to simulate SE window passing over image
for y=1:ylength-2
	for x=1:xlength-2
		window = [input_image(y:(y+2),x:(x+2))];
		window_v = [[window(1,1:3)] [window(2,1:3)] [window(3,1:3)]];
		sorted_list = sort(window_v);
		output_image(y+1,x+1) = sorted_list(order);
	sorted_list(order);
	end
end

%plots ro filtered image
figure;
subplot(121)
image(input_image)
colormap(gray(256));
title('Noisy Image');
subplot(122)
image(output_image)
colormap(gray(256));
title('Rank Order Filter Output');