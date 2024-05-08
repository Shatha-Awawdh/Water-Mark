% Load original and recovered watermarks as grayscale images
original = imread('watermark.jpg');
recovered = imread('recovered_watermarkNoisePepper.jpg');

% Convert the images to double precision for accurate calculations
original = im2double(original);
recovered = im2double(recovered);

% Calculate the mean intensity of the original and recovered watermarks
mean_original = mean(original(:));
mean_recovered = mean(recovered(:));

% Calculate the normalized cross-correlation (NC) between the original and recovered watermarks
numerator = sum((original - mean_original) .* (recovered - mean_recovered), 'all');
denominator = sqrt(sum((original - mean_original) .^ 2, 'all') * sum((recovered - mean_recovered) .^ 2, 'all'));
nc = numerator / denominator;

% Display the NC
fprintf('Normalized Correlation (NC): %f\n', nc);
