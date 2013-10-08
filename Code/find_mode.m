function [out] = find_mode(input_dir)
%reading data
filenames = dir(fullfile(input_dir,'*.jpg'));
num_images = numel(filenames);
out = zeros(1,num_images);
for n = 1:num_images
    filename = fullfile(input_dir,filenames(n).name);
    im = imread(filename);
    if n == 14
        figure,imshow(im);
    end
    [h s v]= rgb2hsv(im);
    out(1,n) = mode(mode(double(h)));
end