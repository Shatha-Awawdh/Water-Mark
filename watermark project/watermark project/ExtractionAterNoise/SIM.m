% Load original and extracted watermarks as grayscale images
original = imread('watermark.jpg');
extracted = imread('recovered_watermarkNoisePepper.jpg');

% Convert the images to double precision for accurate calculations
original = im2double(original);
extracted = im2double(extracted);

% Calculate the numerator of the SIM equation
numerator = sum(sum(original .* extracted));

% Calculate the denominator of the SIM equation
denominator = sqrt(sum(sum(original .^ 2)) * sum(sum(extracted .^ 2)));

% Calculate the SIM
sim = numerator / denominator;

% Display the SIM
fprintf('SIM (Similarity Index Measure): %f\n', sim);
