clear
clc

%% Load Image
img = imread('./spot.jpg');

%% Part A
H = myhistogram(img, 8);

figure;
stem(H, '*')
title('Histogram For Spot (Part A)')

%% Part B
T = threshfinder(img, 10^-12);

figure;
colormap(gray)
subplot(1, 2, 1)
imagesc(img)

subplot(1, 2, 2)
imagesc(T)

%% Part C
figure;
colormap(gray)
subplot(1, 3, 1)
stem(H, '*')
title('Histogram For Spot (Part C)')

subplot(1, 3, 2)
stem(myhistogram(conenhance(img, 8), 8), '*')

subplot(1, 3, 3)
colormap(gray)
imagesc(conenhance(img, 8))

%% Part D
n = 9;
img0 = imread('./cameraman.jpg');
imgset = fading(img, img0, n);

figure;
colormap(gray)
for i = 1:n
    subplot(3, 3, i)
    imagesc(imgset(:, :, i))
end


%% Functions
function threshimg = threshfinder(img, T0)
    
    imgarray = double(img(:));
    uniques = unique(imgarray);
    a = min(uniques);
    b = max(uniques);
    Tpast = 255;
    Tcurrent = (a + b + rand(1)) / 2;
    
    while abs(Tpast - Tcurrent) > T0
        m1 = mean(imgarray .* (imgarray < Tcurrent));
        m2 = mean(imgarray .* (imgarray >= Tcurrent));
        Tpast = Tcurrent;
        Tcurrent = (m1 + m2) / 2;
    end
    
    threshimg = img >= Tcurrent;
end

function H = myhistogram(img, nbits)

    if strcmp(class(img), 'uint8') ~= 0
       img = uint8(img); 
    end
    
    totals = zeros(1, 2^nbits);
    for i = 1:length(totals)
        totals(i) = sum(img(:) == (i - 1));
    end
    
    H = totals;
end

function newimg = conenhance(img, nbits)

    if strcmp(class(img), 'uint8') ~= 0
       img = uint8(img); 
    end

    gray_levels = 0:(2^nbits - 1);
    pk = double(myhistogram(img, nbits)) / numel(img);
    CDF = @(i) sum((gray_levels <= i) .* pk);
    
    J1 = zeros(size(img));
    for i = 1:length(gray_levels)
        idx = img(:) == gray_levels(i);
        J1(idx) = CDF(gray_levels(i));
    end
    
    newimg = floor((2^nbits - 1) * J1);
end

function imageset = fading(A, B, n)

    A = double(A); 
    B = double(B); 
    [r, c] = size(A);
    
    dI = (B - A) / (n - 1);
    Is = zeros(r, c, n);
    
    for i = 1:n
        Is(:, :, i) = (i - 1) * dI + A;
    end
    
    imageset = Is;
end
