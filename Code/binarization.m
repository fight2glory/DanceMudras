function [out] = binarization(in1,in2)
if size(in1,3) > 1
% gray = rgb2gray(in);
gray = in1(:,:,1);
else 
    gray = in1;
end
out = zeros(size(in1,1),size(in1,2));
for a = 1:size(in1,1)
    for b = 1:size(in1,2)
        if (gray(a,b) > in2)
            out(a,b) = 255;
        else
            out(a,b) = 0;
        end
    end
end