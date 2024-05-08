% Load the images
img1 = imread('PeppersRGB.jpg'); % replace 'image1.jpg' with the filename of your first image
%img2 = imread('watermark.jpg'); % replace 'image2.jpg' with the filename of your second image

% Convert the images to grayscale
img1_gray = rgb2gray(img1);
%img2_gray = rgb2gray(img2);

% Get the current directory
currentDir = pwd;

% Create filenames for the stored grayscale images
filename1 = fullfile(currentDir, 'image1_gray.jpg'); % replace 'image1_gray.jpg' with the desired filename for the first grayscale image
%filename2 = fullfile(currentDir, 'image2_gray.jpg'); % replace 'image2_gray.jpg' with the desired filename for the second grayscale image

% Write the grayscale images to the specified filenames
imwrite(img1_gray, filename1);
%imwrite(img2_gray, filename2);

% Display messages indicating the grayscale images have been stored
disp(['First image has been stored as: ' filename1]);
%disp(['Second image has been stored as: ' filename2]);
