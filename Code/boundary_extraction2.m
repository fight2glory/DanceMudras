function [out] = boundary_extraction2(in)
% in = imread('Testset/mudra34.jpg');
[w,h] = size(in);
% for a = 1:w
%     for b = 1:h
%         if(in(a,b,1) > 100)
%             in(a,b,1) = 255;
%         else
%             in(a,b,1) = 0;
%         end
%     end
% end
% figure,imshow(uint8(in(:,:,1)));
% title('Binarized Image')
% se = strel('ball',3,3);
% temp = imdilate(in(:,:,1),se);
% figure,imshow(uint8(temp));

% title('Dilated Hand')
% b = bwlabel(in,8);
% rp = regionprops(b,'Area','PixelIdxList');
% areas = [rp.Area];
% [unused,indexOfMax] = max(areas);
% disp(indexOfMax);
temp = imfill(in,'holes');
figure,imshow(temp);
% title('Region Filled Image')
out = zeros(w,h);
for i=2:w-1
    for j=2:h-1
        if temp(i,j) == 255
            out = boundary_point(temp,out,i,j);
        end
    end
end
for i=2:w-1
    for j=2:h-1
        if out(i,j) == 255
            out = boundary_point2(out,i,j);
        end
    end
end
figure()
imshow(uint8(out),[]);
title('Boundary')
end
function [out] = boundary_point(in,out,i,j)
if in(i-1,j-1)==0 || in(i-1,j)==0 || in(i-1,j+1)==0 || in(i,j-1)==0 || in(i,j+1)==0 || in(i+1,j-1)==0 || in(i+1,j)==0 || in(i+1,j+1)==0
    out(i,j) = 255;
end
end

function [out] = boundary_point2(out,i,j)
if((out(i,j-1)==255 && out(i-1,j) == 255) || (out(i-1,j)==255 && out(i,j+1) == 255) || (out(i,j+1)==255 && out(i+1,j) == 255) || (out(i+1,j)==255 && out(i,j-1) == 255))
out(i,j) = 0;
end
end
% out = zeros(w,h);
% se = strel('line',5,0);
% t = imerode(temp2(:,:,1),se);
% figure,imshow(uint8(t));
% title('Eroded Image')
% out = temp2 - t;
% figure()
% imshow(uint8(out));
% title('External Boundary')
% out = in(:,:,1);
% out1 = temp2 - in(:,:,1);
% figure,imshow(uint8(out1));
% out3 = temp2 - in(:,:,1);
% figure,imshow(uint8(out3));