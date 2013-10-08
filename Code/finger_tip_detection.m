function [dis,center_of_hand,out] = finger_tip_detection(in)
% in = imread('B.jpg');
[M,N] = size(in(:,:,1));
for a = 1:M
    for b = 1:N
        if(in(a,b,1) > 100)
            in(a,b,1) = 255;
        else
            in(a,b,1) = 0;
        end
    end
end
origin = [round(M/2),N];
out = zeros(M,N);
dis = double(zeros(M,N));
[r,c] = find(in(:,:,1) == 255);
for a = 1:size(r,1)
    dis(r(a),c(a)) = sqrt((r(a) - origin(1))^2 + (c(a) - origin(2))^2);
end

finger_tips = zeros(M,N);
mi_c = min(c);
ma_c = max(c);
ma_r = max(r);
mi_r = min(r);
center_of_hand = [round((ma_r + mi_r)/2),round((ma_c + mi_c)/2)];
for a = 1:M
    if( a > center_of_hand(1))
        dis(a,:) = - dis(a,:);
    end
end
len = floor((ma_c-mi_c)/5);
for i = mi_c:len:ma_c-len+1
    tip = max(max(dis(:,i:i+len-1)));
    [x,y] = find((dis(:,i:i+len-1)) == tip);
    finger_tips(x,y+i) = 255;
end
% out(center_of_hand(1),center_of_hand(2)) = 255;
[p1,p2] = find(finger_tips == 255);
for a = 1:size(p1,1)
    if(sqrt((p1(a) - center_of_hand(1))^2 + (p2(a) - center_of_hand(2))^2) > 20)
        out(p1(a),p2(a)) = 255;
    end
end
figure,imshow(out);
title('Tips')


