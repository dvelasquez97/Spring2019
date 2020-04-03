clear
clc

%% Exercise 1: On Paper

%% Exercise 2
moon = imread('./Moon.jpg');
lap = ones(3, 3);
lap(2, 2) = -8;

g = moon - imfilter(moon, lap);

figure;
subplot(1, 2, 1)
imshow(moon, [])

subplot(1, 2, 2)
imshow(g, [])

%% Exercise 3
spiral = imread('./spiral.jpg');
spiralGray = rgb2gray(spiral);
spiralBW = imbinarize(spiralGray, graythresh(spiralGray));

figure;
subplot(1, 2, 1)
imshow(spiralBW, [])

subplot(1, 2, 2)
imshow(spiralBW - imerode(spiralBW, strel('disk', 2)), [])