clear
clc

%% load image
img = imread("../PlayImages/Cat.jpg");
[r, c] = size(img);
if r == c
    band = eye(r, class(img)) .* (255 - img);
    X = band + imrotate(band, 90);
    I = X + img;
    figure;
    colormap(gray)
    imagesc(I)
end

