clear
clc

%% Read Image
I = imread('./Moon.jpg');

%% Exercise 2
mask = [1, 1, 1; 1, -8, 1; 1, 1, 1];
Ilap = imfilter(I, mask);
Ifilt = I - Ilap;

figure;
subplot(1, 2, 1)
imshow(I, [])
title('Original')

subplot(1, 2, 2)
imshow(Ifilt, [])
title('Enhanced')

%% Exercise 3
mnist = rgb2gray(imread('./mnist.png'));
mnist = imbinarize(mnist, graythresh(mnist));

figure;
subplot(1, 2, 1)
imshow(mnist, [])
title('Original')

subplot(1, 2, 2)
imshow(mnist - imerode(mnist, strel('Disk', 5)), [])
title('Contour (5x5)')







