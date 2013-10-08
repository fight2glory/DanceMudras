function [out] = skin_detection2(in)
%in = imread('5.jpg');

%  useless

C = max(in, [], 1) ;
D = max(C);
E = [D(1,1,1) D(1,1,2) D(1,1,3) ];
mx = max(E);
C = min(in, [], 1) ;
D = min(C);
E = [D(1,1,1) D(1,1,2) D(1,1,3) ];
mn = min(E);
mx = (255.0*(mx-mn))/(mx+mn);
% % % % % % % % % % % % % 
[M N O] = size(in);
%  RGB
Simple = zeros([M N]);
for a = 1:M
    for b = 1:N
        if(in(a,b,1) >= 180 && in(a,b,2)<=180 && in(a,b,3) >= 150 &&  abs((in(a,b,1)-in(a,b,2))<=150))
            Simple(a,b)=255;
        else
            Simple(a,b)=0;
        end
    end
end
% imshow(Simple,[]);

% YCbCr SPACE

Y = rgb2ycbcr(in);
YCC = zeros([M N]);
for a = 1:M
    for b = 1:N
        if(Y(a,b,2) >= 70 && Y(a,b,2)<=133 && Y(a,b,3) >= 130 && Y(a,b,3)<=173)
            YCC(a,b)=255;
        else
            YCC(a,b)=0;
        end
    end
end
% imshow(YCC,[])
in = double(in);


%  HSV SPACE

[H S V] = rgb2hsv(in);
HSV = zeros([M N]);
for a = 1:M
    for b = 1:N
        if(((H(a,b)>=0 && H(a,b)<=40.0/360.0)||(H(a,b)>=300.0/360.0 && H(a,b)<=1.0))&& S(a,b) >= 0.15 && S(a,b)<=0.8 && V(a,b)>=40)
            HSV(a,b)=255;
        else
            HSV(a,b)=0;
        end
    end
end
% imshow(HSV,[]);


%  HSV2
HSV2 = zeros([M N]);
for a = 1:M
    for b = 1:N
        if(V(a,b)>=40 && H(a,b)*360.0-180.0<= -0.4*V(a,b)+75 && (S(a,b)*mx>=10 && S(a,b)*mx<=-360.0*H(a,b)-180.0-.1*V(a,b)+110))
            if(H(a,b)*360.0-180.0>=0 && S(a,b)*mx<=.08*(H(a,b)*360.0-180.0)*(100-V(a,b))+0.5*V(a,b))
            HSV2(a,b)=255;
            else
               if(H(a,b)*360.0-180.0<0 && S(a,b)*mx<=35.0+0.5*(360.0*H(a,b)-180.0))
                HSV2(a,b)=255;
               else
                HSV2(a,b)=0;
               end
            end
            
        end
    end
end
% figure,imshow(HSV2,[]);

%  HSI SPACE
r = in(:, :, 1);
g = in(:, :, 2);
b = in(:, :, 3);

% Implement the conversion equations.
num = 0.5*((r - g) + (r - b));
den = sqrt((r - g).^2 + (r - b).*(g - b));
theta = acos(num./(den + eps));

H = theta;
H(b > g) = 2*pi - H(b > g);
H = H/(2*pi);
H = H*360.0;
num = min(min(r, g), b);
den = r + g + b;
den(den == 0) = eps;
S = 1-3.* num./den;
S = S*100;
H(S == 0) = 0;

I = (r + g + b)/3;

% Combine all three results into an hsi image.
hsi = cat(3, H, S, I);



%  OR all images

out = zeros([M N]);

for i=1:M
    for j=1:N
        if(YCC(i,j)||HSV(i,j)||Simple(i,j))
            out(i,j)=255;
        else
            out(i,j)=0;
        end
    end
end


figure,imshow(uint8(out));
title('Extracted Hands')
% figure,imshow(uint8(im(:,:,1)))
end