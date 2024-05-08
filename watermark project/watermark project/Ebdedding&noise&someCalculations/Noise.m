
% Load grayscale image
image = imread('grayPeppers.jpg');

% Convert the image to double precision for accurate calculations
image = im2double(image);

% Specify noise parameters
noise_density = 0.02; % Noise density (percentage of pixels)
noise_intensity = 0.5; % Intensity of the noise

% Generate salt and pepper noise
noise = rand(size(image)); % Generate random values between 0 and 1
salt_pixels = find(noise <= noise_density / 2); % Identify pixels for salt noise
pepper_pixels = find(noise > 1 - noise_density / 2); % Identify pixels for pepper noise
image(salt_pixels) = noise_intensity; % Apply salt noise
image(pepper_pixels) = 0; % Apply pepper noise

% Display the original and noisy images
subplot(1, 2, 1);
imshow(imread('grayPeppers.jpg'));
title('Original Image');
subplot(1, 2, 2);
imshow(image);
title('Noisy Image (Salt and Pepper)');

% Save the noisy image
imwrite(image, 'noisy_image.png');


