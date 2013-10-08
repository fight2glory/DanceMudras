close all;
clear all;
clc;

%reading data
input_dir = './Boundaries';
image_dims = [64,48];
filenames = dir(fullfile(input_dir, '*.jpg'));
num_images = numel(filenames);
images = [];

%Making a matrix out of dataset
for n = 1:num_images
    filename = fullfile(input_dir,filenames(n).name);
    img = imread(filename);
    %img = rgb2gray(img); 
% %   
    img = imresize(img,[image_dims(1), image_dims(2)]);
% %
%     figure,imshow(img);
    if n == 1
        images = zeros(prod(image_dims),num_images);
    end
% %    image(:,n) = img(:);
    images(:,n) = cat(2,img(:));
end

% Training
%calculating mean face
mean_face = mean(images,2);
mf = reshape(mean_face,image_dims(1),image_dims(2));
figure,imshow(uint8(mf));
title('Mean Face')
%subtracting mean from each face image
shifted_images = images - repmat(mean_face,1,num_images);
%calculating eigenvalues and eigenvectors
[evectors,score,evalues] = princomp(images');
%retaining only top principal componenets
%for x = 1:15
num_eigenvectors = 20;
%num_eigenvectors = x;
evec = evectors(:,1:num_eigenvectors);
% project the images into the subspace 
features = evec' * shifted_images;% input = input('Face to be classified: ','s');
% input_image = imread(input);
% if (size(input_image,3) > 1)
%     input_image = rgb2gray(input_image);
% end
input_image = imread('Trainingset/testpic.jpg');
%input_image = rgb2gray(input_image);
input_image = imresize(input_image,[image_dims(1),image_dims(2)]);
% %Classification
% %calculating the similarity of the input to each training image
 feature_vec = evec' * (double(input_image(:)) - mean_face);
 similarity_score = arrayfun(@(n) 1/(1+ norm(features(:,n) - feature_vec)), 1:num_images);
% 
% % find the image with the highest similarity
 [match_score,match_ix] = max(similarity_score);
% 
% %display the results
 figure,imshow([input_image reshape(images(:,match_ix),image_dims)]);
% title(sprintf('matches %s , score %f', filenames(match_ix).name,match_score));

% % display the eigenevectors
% figure,
% for n = 1:num_eigenvectors
%     subplot(2,ceil(num_eigenvectors/2),n);
%     ev = reshape(evec(:,n),image_dims);
%     imshow(ev,[min(min(ev)),max(max(ev))]);
%     
% end
% 
% %Reconstruct
% a = repmat(feature_vec,1,size(evec,1));
% b = a' .* evec;
% c = sum(b,2);
% d = reshape(c,image_dims);
% figure,
% subplot(2,1,1),imshow(input_image);
% title('Original Image')
% subplot(2,1,2),imshow(uint8(d),[min(min(d)),max(max(d))]);
% title('Reconstructed Image')
% 
% %Calculating RMSE
% diff_sq = (d - double(input_image)).^2;
% rmse = sqrt(sum(sum(diff_sq,2),1)/prod(size(d)))- 50;
% disp(rmse);

%end

