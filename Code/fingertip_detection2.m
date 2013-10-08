function[] = fingertip_detection2(in)
[r,c] = size(in);
visited = zeros(r,c);
k = 2;
flag = 0;
for i=100:100
    for j=1:c
        
        k = 5;
        if in(i,j) == 255
%             disp('abc');
            visited(i,j) = 255;
            neighbours = get_neighbours(in,visited,i,j);
            for p=1:8
                if neighbours(p,1) == 0
                    break;
                end
                neighbours(p,:)
                endpt = DFS(in,neighbours(p,:),visited,k)
            end
            visited = zeros(r,c);
            flag = 1;
        end
        if flag == 1
            break;
        end
    end
end
end

function rec = DFS(in,cur,visited,k)
visited(cur(1),cur(2)) = 255;
figure,imshow(visited);
if k==0 
    rec = cur;
end
neighbours = get_neighbours(in,visited,cur(1),cur(2));
k = k-1;
k
for p=1:8
    if neighbours(p,1) == 0
            break;
    end
    neighbours(p,:)
    rec = DFS(in,neighbours(p,:),visited,k);
    
end
rec = zeros(1,2);
end

function[neighbours] = get_neighbours(in,visited,i,j)
neighbours = zeros(8,2);
k=1;
in(i,j) = 0;
for p=-1:1
    for q=-1:1
        if in(i+p,j+q) == 255 && visited(i+p,j+q)~=255
            neighbours(k,1) = i+p;
            neighbours(k,2) = j+q;
            k = k+1;
        end
    end
end
in(i,j) = 255;
end
     