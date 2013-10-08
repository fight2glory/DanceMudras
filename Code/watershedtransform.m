function [] = watershedtransform(I)
% clear all;
% close all;
% clc;
% 
% I = imread('./Testset/mudra15.jpg');
% I2 = rgb2gray(I);
% BW1 = edge(I2,'sobel',0.045);
% [BW2,thres] = edge(I2,'canny',[0.12,0.1600]);
% BW3 = edge(I2,'prewitt');
% figure,
% subplot(1,3,1),imshow(BW1);
% subplot(1,3,2),imshow(BW2);
% subplot(1,3,3),imshow(BW3);
% L = bwlabel(BW3,8);
% temp = BW3;
% mx = max(max(L));
% for a = 1:mx
%     ind = find(L == a);
%     if(size(ind) < 20)
%         temp(ind) = 0;
%     end
% end
% figure,imshow(temp);

%k-means clustering



%watershed transform
% rgb = imread('./Testset/mudra56.jpg');
% I = rgb2gray(rgb);
% figure,imshow(I)

hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
figure, imshow(gradmag,[]), title('Gradient magnitude (gradmag)')

L = watershed(gradmag);
Lrgb = label2rgb(L);
figure, imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)')

se = strel('disk', 20);
Io = imopen(I, se);
figure, imshow(Io), title('Opening (Io)')

Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
figure, imshow(Iobr), title('Opening-by-reconstruction (Iobr)')
temp = Iobr;
for a = 1:size(Iobr,1)
    for b = 1:size(Iobr,2)
        if(Iobr(a,b) < 185)
            temp(a,b) = 0;
        end
    end
end

figure,imshow(temp);
title('temp')

Ioc = imclose(Io, se);
figure, imshow(Ioc), title('Opening-closing (Ioc)')

Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
figure, imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')

fgm = imregionalmax(Iobrcbr);
figure, imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')

I2 = I;
I2(fgm) = 255;
figure, imshow(I2), title('Regional maxima superimposed on original image (I2)')

se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);

fgm4 = bwareaopen(fgm3, 20);
I3 = I;
I3(fgm4) = 255;
figure, imshow(I3)
title('Modified regional maxima superimposed on original image (fgm4)')

bw = im2bw(Iobrcbr, graythresh(Iobrcbr));
figure, imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')

D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
figure, imshow(bgm), title('Watershed ridge lines (bgm)')

gradmag2 = imimposemin(gradmag, bgm | fgm4);

L = watershed(gradmag2);

I4 = I;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
figure, imshow(I4)
title('Markers and object boundaries superimposed on original image (I4)')

Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
figure, imshow(Lrgb)
title('Colored watershed label matrix (Lrgb)')

figure, imshow(I), hold on
himage = imshow(Lrgb);
set(himage, 'AlphaData', 0.3);
title('Lrgb superimposed transparently on original image')