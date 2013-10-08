function [out] = boundary_extraction(in)
% in = imread('Testset/mudra34.jpg');
[w,h] = size(in(:,:,1))
for a = 1:w
    for b = 1:h
        if(in(a,b,1) > 100)
            in(a,b,1) = 255;
        else
            in(a,b,1) = 0;
        end
    end
end
figure,imshow(uint8(in(:,:,1)));
title('Binarized Image')
se = strel('ball',3,3);
temp = imdilate(in(:,:,1),se);
figure,imshow(uint8(temp));
title('Dilated Hand')
temp2 = imfill(temp(:,:,1),'holes');
figure,imshow(uint8(temp2))
title('Region Filled Image')
out = zeros(w,h);
se = strel('line',5,0);
t = imerode(temp2(:,:,1),se);
figure,imshow(uint8(t));
title('Eroded Image')
out = temp2 - t;
figure()
imshow(uint8(out));
title('External Boundary')
out = in(:,:,1);
% out1 = temp2 - in(:,:,1);
% figure,imshow(uint8(out1));
% out3 = temp2 - in(:,:,1);
% figure,imshow(uint8(out3));
