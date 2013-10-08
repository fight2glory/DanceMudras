function[] = fingertip_detection3(in)
[r,c] = size(in);
visited = zeros(r,c);
k = 5;
vec = zeros(2,2);
cosarr = double(ones(500,1));
corrcos = double(ones(r,c));
corrcos = corrcos*-2;
cosarr = cosarr*-2;
count = 1;
points = 0;
for i=1:r
    for j=1:c
        if in(i,j) == 255
            points = points + 1;
            v = 1;
            visited(i,j) = 255;
            neighbours = get_neighbours(in,visited,i,j);
            for p=1:8
                k = 7;
                if neighbours(p,1) == 0
                    break;
                end
                %neighbours(p,:)
                endpt = DFS(in,neighbours(p,:),visited,k);
                vec(v,1) = i-endpt(1);
                vec(v,2) = j-endpt(2);
                v = v+1;
            end
            dotp = dot(vec(1,:),vec(2,:));
            mag1 = sqrt(vec(1,1)*vec(1,1) + vec(1,2)*vec(1,2));
            mag2 = sqrt(vec(2,1)*vec(2,1) + vec(2,2)*vec(2,2));
            costheta = dotp/(mag1*mag2);
            corrcos(i,j) = costheta;
            cosarr(count) = costheta;
            count = count+1;
            visited = zeros(r,c);
        end
    end
end
cosarr = sort(cosarr,'descend');
final(cosarr,corrcos,r,c);

end

function[] = final(cosarr,coscorr,r,c)
count = 0;
final_im = zeros(r,c);
    for i=1:r
        for j=1:c
            for k = 1:30
                if cosarr(k) == coscorr(i,j)
                    count = count+1;
                    final_im(i,j) = 255;
                end
            end
        end
    end
figure,imshow(final_im);
end

function rec = DFS(in,cur,visited,k)
visited(cur(1),cur(2)) = 255;
%figure,imshow(visited);
if k==0 
    rec = cur;
    return;
end
neighbours = get_neighbours(in,visited,cur(1),cur(2));
if neighbours(1,1) == 0
    rec = cur;
    return;
end
k = k-1;
for p=1:8
    if neighbours(p,1) == 0
            break;
    end
    %neighbours(p,:)
    rec = DFS(in,neighbours(p,:),visited,k);
    
end
%rec = zeros(1,2);
end

function[neighbours] = get_neighbours(in,visited,i,j)
neighbours = zeros(8,2);
k=1;
in(i,j) = 0;
for p=-1:1
    for q=-1:1
%         if in(i+p,j+q) == 255
%             i+p
%             j+q
%         end
        if in(i+p,j+q) == 255 && visited(i+p,j+q)~=255
            neighbours(k,1) = i+p;
            neighbours(k,2) = j+q;
            k = k+1;
        end
    end
end
in(i,j) = 255;
end
     