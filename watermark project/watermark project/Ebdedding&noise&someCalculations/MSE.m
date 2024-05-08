% Load original and recovered watermarks as grayscale images
original = imread('watermark.jpg');
recovered = imread('recovered_watermark.jpg');

% Convert the images to double precision for accurate calculations
original = im2double(original);
recovered = im2double(recovered);

% Calculate the squared difference between the original and recovered watermarks
squared_diff = (original - recovered) .^ 2;

% Calculate the MSE as the mean of the squared differences
mse = mean(squared_diff(:));

% Display the MSE
fprintf('Mean Squared Error (MSE): %f\n', mse);
