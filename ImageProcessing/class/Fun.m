clear
clc

%% Import Image
img = imread("../PlayImages/cameraman.jpg");
figure;
colormap(gray)
imagesc(img)

%% Histogram
figure;
histogram(img(:))

%% Thresholding
figure;
colormap(gray)
imagesc(imbinarize(img, graythresh(img)))

%% Convolution For X-Direction Edges
S = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
dx = conv2(img, S);
figure;
colormap(gray)
imagesc(dx)

%% Convolution For Y-Direction Edges
dy = conv2(img, S');
figure;
colormap(gray)
imagesc(dy)

%% Magnitude of Image Gradient (Sobel)
dgrad = sqrt(dx.^2 + dy.^2);
figure;
colormap(gray)
imagesc(dgrad)

%% Laplacian 
L = [0, 1, 0; 1, -4, 1; 0, 1, 0];
dlap = conv2(img, L);
figure;
colormap(gray)
imagesc(dlap)

%% Frequency Domain
Img = fftshift(fft2(img));
colormap(gray)
imagesc(log10(abs(Img)))

%% Filtering in Frequency (using a circle)
p = 0.8;
[r, ~] = size(Img);
center = floor(mean(1:r));
rad = floor(p * center);

for i = 1:r
    for j = 1:r
        
    end
end






