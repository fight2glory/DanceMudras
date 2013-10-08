close all;
clear all;
clc;

% filenames = dir(fullfile('./Final_Dataset','*.jpg'));
% num_images = numel(filenames);
% ind = randi(num_images,1);
% filename = fullfile('./Final_Dataset',filenames(ind).name);
% im = imread(filename);
% im = imread('Testset');
% path = input('Path of image to be classified: ');
% im = imread(path);
im = imread('Final_Dataset/57.jpg');
figure,imshow(im);
title('Original Image');
[h s v] = rgb2hsv(im);
m = mode(mode(h));
if (m >= 0.6190 && m <= 0.7581)
disp('Single Hand Mudra without accessories is being classified:');
hands = skin_detection2(im);
contour = boundary_extraction2(hands);
fingertip_detection3(contour);
elseif (m > 0 && m <= 0.3000) || (m == 0.9899)
    disp('Single Hand with accesories in Complex Background:');
    [I1,I2,I3] = clustering(im);
    temp1 = skin_detection(I1);
    temp2 = skin_detection(I2);
    temp3 = skin_detection(I3);
    a = find(temp1 ~= 0);
    b = find(temp2 ~= 0);
    c = find(temp3 ~= 0);
    s1 = size(a);
    s2 = size(b);
    s3 = size(c);
    ind = max([s1,s2,s3]);
    if ind == s1(1)
        hands = I1(:,:,:);
    elseif ind == s2(1)
        hands = I2(:,:,:);
    elseif ind == s3(1)
        hands = I3(:,:,:);
    end
    figure,imshow(uint8(hands));
    title('Hand')
    binary_hands = binarization(hands,0);
    figure,imshow(binary_hands);
    title('Binarized Hand')
    L = bwlabel(binary_hands,8);
    num_blobs = max(max(L));
    for n = 1:num_blobs
        [r,c] = find(L == n);
        if size(r,1) <= 1500
            binary_hands(r,c) = 0;
        end
    end
    contour = boundary_extraction2(binary_hands);
    fingertip_detection3(contour);
    figure,imshow(binary_hands)
    title('Only Hands')
elseif m == 0
    disp('Hand with accesories and Plain Background')
    hands = mehendi_removal(im);
    h = fspecial('sobel');
    edge = conv2(hands,h);
    figure,imshow(edge);
    binary_hands = binarization(hands,50);
    figure,imshow(uint8(binary_hands));
    contour = boundary_extraction2(binary_hands);
    fingertip_detection3(contour);
elseif m >= 0.9680 && m <= 0.9690
disp('Single Hand with accessories in Complex Background2')
hands = mehendi_removal(im);
binary_hand = binarization(hands,200);
figure,imshow(binary_hand);
title('Binary Hand')
else
    disp('Cannot classify hand');
end
% [I1,I2,I3] = clustering(im);
% hands = skin_detection2(I2);
% watershedtransform(rgb2gray(I2));
% contour = boundary_extraction2(I2);
