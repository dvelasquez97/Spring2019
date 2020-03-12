clear
clc

%% Read Image
I = double(imread('../PlayImages/cameraman.jpg'));

%% Prewitt Operator
dY = [-1, 0, 1; -1, 0, 1; -1, 0, 1] / 3;
dX = dY';

[m, n] = size(I);
Ix = zeros(m - 1, n - 1);
Iy = zeros(m - 1, n - 1);
for i = 2:(n - 1)
    for j = 2:(n - 1)
        window = I((i - 1):(i + 1), (j - 1):(j + 1));
        tempx = dX .* window;
        tempy = dY .* window;
        Ix(i - 1, j - 1) = sum(tempx(:));
        Iy(i - 1, j - 1) = sum(tempy(:));
    end
end

Iedges = sqrt(Ix.^2 + Iy.^2);
Ix_norm = Ix ./ max(Ix(:));
Iy_norm = Iy ./ max(Iy(:));
Iedges_norm = Iedges ./ max(Iedges(:));

T = 0.3;

figure;
subplot(2, 2, 1)
imshow(I, [])
title('Original')

subplot(2, 2, 2)
imshow(abs(Ix_norm) > T, [])
title('Ix')

subplot(2, 2, 3)
imshow(abs(Iy_norm) > T, [])
title('Iy')

subplot(2, 2, 4)
imshow(abs(Iedges_norm) > T, [])
title('Magnitude of Ix and Iy')

%% 
Ix_thresh = threshfinder(abs(Ix_norm), 10^-12)
Iy_thresh = threshfinder(abs(Iy_norm), 10^-12)



%% Functions
function threshold = threshfinder(img, T0)
   
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
    
    threshold = Tcurrent;
end



