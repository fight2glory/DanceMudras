close all;
clear all;
clc;
I = imread('Interim 2/Images in Report 2/Final_Dataset/mudra51.jpg');
[M,N,D] = size(I);
for a = 1:M
    for b = 1:N
        if(I(a,b,:) < 50)
            I(a,b,:) = 255;
        else
            I(a,b,:) = 0;
        end
    end
end
figure,imshow(I);