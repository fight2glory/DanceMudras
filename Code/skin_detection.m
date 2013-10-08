function [out] = skin_detection(in)
in = double(in);
[hue,s,v]=rgb2hsv(in);
cb =  0.148* in(:,:,1) - 0.291* in(:,:,2) + 0.439 * in(:,:,3) + 128;
cr =  0.439 * in(:,:,1) - 0.368 * in(:,:,2) -0.071 * in(:,:,3) + 128;
[w h]=size(in(:,:,1));
segment = zeros(w,h);
out = zeros(w,h,3);
for i=1:w
    for j=1:h            
        if  120<=cr(i,j) && cr(i,j)<=190 && 140<=cb(i,j) && cb(i,j)<=195 && 0.01<=hue(i,j) && hue(i,j)<=0.1     
            segment(i,j)=1;            
        else       
            segment(i,j)=0;    
        end    
    end
end
% imshow(segment);
hands(:,:,1)=in(:,:,1).*segment;   
hands(:,:,2)=in(:,:,2).*segment; 
hands(:,:,3)=in(:,:,3).*segment;
% hands2 = rgb2gray(hands);
% for a = 1:size(hands2,1)
%     for b = 1:size(hands2,2)
%         if(hands2(a,b)~= 0)
%             out(a,b) = 255;
%         else
%             out(a,b) = 0;
%         end
%      end
% end
out = hands;
figure,imshow(uint8(out));
title('Extracted Hands')
% figure,imshow(uint8(im(:,:,1)))


