clear
clc

%% Read Image
I = imread('../PlayImages/spiral.jpg');
I = double(rgb2gray(I));

%% 1st derivatives
[Ix, Iy] = imgradientxy(I);

%% 2nd derivatives
[Ixx, Ixy] = imgradientxy(Ix);
[Ixy, Iyy] = imgradientxy(Iy);

%% Curl of Curl
C = sqrt(Ixy.^2 + Ixy.^2);
imshow(C, [])

%% Orthogonal Curl of Orthogonal Curl
C = sqrt((Iyy - Ixy + Ixx).^2 + (Iyy - Ixy + Ixx).^2);
imshow(C, [])

%% Curl of Orthogonal Curl
C = sqrt(2 * Ixy.^2 - 4 * Ixy .* Iyy + 4 * Iyy.^2);
imshow(C, [])