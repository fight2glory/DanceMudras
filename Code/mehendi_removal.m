function [out] = mehendi_removal(in);
% in = imread('./Testset/mudra54.jpg');
out = in(:,:,1);
figure,imshow(out);
title('Hand without mehendi');