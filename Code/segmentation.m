clear all;
close all;
clc;
% function [] = segmentation()
I = imread('Testset/mudra2.jpg');
% I2 = rgb2hsv(I);
% % (I2(:,:,3)/min(min(I2(:,:,3))))
% % (I2(:,:,3)/max(max(I2(:,:,3))))*255;
% 
% % for a = 1:size(I2,1)
% %     for b = 1:size(I2,2)
% %         if(I2(a,b,1) < 0.07)
% %             I2(a,b,1) = 0;
% %         else
% %             I2(a,b,1) = 255;
% %         end
% %     end
% % end
% % I = hsv2rgb(I2);
% % figure(),imshow(I2(:,:,1));
% I3 = rgb2ycbcr(I);
% for a= 1:size(I3,1)
%     for b = 1:size(I3,2)
%         if(I3(a,b,1) > 80)
%             I3(a,b,1) = 255;
%         else
%             I(a,b,:) = 0;
%         end
%         if(I3(a,b,2) > 85 & I3(a,b,2) < 135)
%             I(a,b,:) = 255;
%         else
%             I3(a,b,2) = 0;
%         end
%         if(I3(a,b,3) > 135 & I3(a,b,3) < 180)
%             I3(a,b,3) = 255;
%         else
%             I3(a,b,3) = 0;
%         end
%     end
end
figure,imshow(I(:,:,1));
% recon = ycbcr2rgb(I3);
% figure(),imshow(recon(:,:,1));
% for a = 1:size(recon,1)
%     for b = 1:size(recon,2)
%         if(recon(a,b,1) ~= 255 & recon(a,b,1) ~= 0)
%             recon(a,b,1) = 255;
%         else
%             recon(a,b,1) = 0;
%         end
%     end
% end
% figure(),imshow(recon(:,:,1));

% se1 = strel('ball',10,5);
% se2 = strel('square',4);
% I4 = imerode(recon(:,:,1),se1);
% I5 = imerode(recon(:,:,1),se2);

% boundary = I - I2;
% figure()
% figure(),imshow(I4);
% figure(),imshow(I5);
% L = bwlabel(recon(:,:,1),4);
% [r,c] = find(L == 1);
% for a = 1:size(recon,1)
%     for b = 1:size(recon,2)
%         if(L ~=1)
%             recon(a,b,1) = 0;
%         end
%     end
% end
% figure(),imshow(recon(:,:,1))
% I = rgb2gray(I);
% figure()
% imshow(I);
% [M,N,D] = size(I);
% T = 50;
% for a = 1:M
%     for b = 1:N
%         if (I(a,b,:) < T)
%             I(a,b,:) = 0;
%         else
%             I(a,b,:) = 255;
%         end
%     end
% end
% figure()
% imshow(I);
% % [start(1),start(2)] = find(I == 255,1,'last');
% % done = 0; 
% % p = [start(1),start(2)];
% boundary = zeros(M,N);
% se = strel('line',3,0);
% I2 = imerode(I,se);
% boundary = I - I2;
% figure()
% imshow(boundary);

% [C1,C2,C3] = find(boundary == 255);
% finger_tips = zeros(M,N);
% for k = 6:(size(C1,1) - 5)
%     x = C1(k);
%     y = C2(k);
%     x1 = C1(k - 5);
%     y1 = C2(k - 5);
%     x2 = C1(k + 5);
%     y2 = C2(k + 5);
%     if(x1 > x)
%         a = 5;
%     else
%         a = -5;
%     end
%     if(y1 > y)
%         b = 5;
%     else
%         b = -5;
%     end
%     if(x2 > x)
%         c = 5;
%     else
%         c = -5;
%     end
%     if(y2 > y)
%         d = 5;
%     else
%         d = -5;
%     end
%     if((a*c + b*d) == 0)
%         finger_tips(x,y) = 255;
%     end
%     
% end
% 
% tips = bwmorph(finger_tips,'dilate');
% figure()
% imshow(finger_tips);



% F = fspecial('gaussian');
% B = convn(boundary,F);
% 
% figure()
% imshow(B);
% boundary(p(1),p(2)) = 255;
% rotate = 0;
% while(done == 0)
%         prev = p;
%         if (rotate == 0)
%            P1 = [p(1)-1,p(2)-1];
%            P2 = [p(1)-1,p(2)];
%            P3 = [p(1)-1,p(2)+1];
%        elseif(rotate == 3)
%            P1 = [p(1)-1,p(2)+1];
%            P2 = [p(1),p(2)+1];
%            P3 = [p(1)+1,p(2)+1];
%        elseif(rotate == 2)
%            P1 = [p(1)+1,p(2)-1];
%            P2 = [p(1)+1,p(2)];
%            P3 = [p(1)+1,p(2)+1];
%        elseif(rotate == 1)
%            P1 = [p(1)-1,p(2)-1];
%            P2 = [p(1)-1,p(2)];
%            P3 = [p(1)-1,p(2)+1];
%        end
%        if(I(P1(1),P1(2)) == 255 & P1(1) <= M & P1(2) <= N)
%            p(1) = P1(1);
%            p(2) = P1(2);
%            boundary(p(1),p(2)) = 255;
%        elseif(I(P2(1),P2(2)) == 255 & P2(1) <= M & P2(2) <= N)
%            p(1) = P2(1);
%            p(2) = P2(2);
%            boundary(p(1),p(2)) = 255;
%        elseif(I(P3(1),P3(2)) == 255 & P3(1) <= M & P3(2) <= N)
%            p(1) = P3(1);
%            p(2) = P3(2);
%            boundary(p(1),p(2)) = 255;
%        end
%        if(prev == p)
%            rotate = rotate +1;
%        else
%            rotate = 0;
%        end
%        if(p == start | (rotate == 4 & prev == p))
%        done = 1;
%        end
%            
% figure(3)
% imshow(uint8(boundary));
% end



