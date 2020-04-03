clear
clc

%% Exercise 1
mam = imread('mammogram.jpg');
thresh = 100; % by inspection of the histogram
result1 = mam < thresh;
result2 = ApproxContour(result1, 0.1, @edgedecision);
imshow(result2)


%% Exercise 2
mnist = rgb2gray(imread('./mnist.png'));
mnistBW = imbinarize(mnist, graythresh(mnist));
TBW = mnistBW(371:417, 141:185);
J1 = TemplateMatch(mnistBW, TBW, @bwmatch);
J2 = J1 <= 0.95;

figure;
subplot(2, 2, 1)
imshow(mnist, [])

subplot(2, 2, 2)
imshow(TBW, [])

subplot(2, 2, 3)
imshow(J1, [])

subplot(2, 2, 4)
imshow(J2, [])

%% Exercise 3

n = numel(mnist);
H = myhistogram(mnist);
pk = H / n;
ck = cumsum(pk);
levels = 0:(2^8 - 1);

J1 = zeros(size(mnist));
for i = 1:length(levels)
   idx = mnist == levels(i);
   J1(idx) = ck(i);
end
J = round((2^8 - 1) * J1);

figure;
imshow(J, [])

%% Extra Credit

TGray = mnist(371:417, 141:185);
J1 = TemplateMatch(mnist, TGray, @graymatch);
J1 = J1 / max(J1(:));
J2 = J1 <= 0.95;

figure;
subplot(2, 2, 1)
imshow(mnist, [])

subplot(2, 2, 2)
imshow(TGray, [])

subplot(2, 2, 3)
imshow(J1, [])

subplot(2, 2, 4)
imshow(J2, [])


%% Functions
function finalimg = ApproxContour(img, b, f)

    n = 3;
    [r, c] = size(img);
    finalimg = zeros(r - 2, c - 2);

    for x = 2:(r - 1)
        for y = 2:(c - 1)

            W = img((x - 1):(x + 1), (y - 1):(y + 1));
            functionlogic = f(W, n, b);
            finalimg(x - 1, y - 1) = functionlogic;
        end
    end

end

function edgescore = edgedecision(W, n, b)
    edgescore = (sum(W(:)) / (n^2) > (0.5 - b)) && (sum(W(:)) / (n^2) < (0.5 + b));
end

function finalimg = TemplateMatch(img, T, f)   

    [r, c] = size(img);
    [rT, cT] = size(T);
    rcorrect = floor(rT / 2);
    ccorrect = floor(cT / 2);
    finalimg = zeros(r - rcorrect, c - ccorrect);

    for x = (1 + rcorrect):(r - rcorrect)
        for y = (1 + ccorrect):(c - ccorrect)
            W = img((x - rcorrect):(x + rcorrect), ...
                (y - ccorrect):(y + ccorrect));
            functionlogic = f(W, T);
            finalimg(x - rcorrect, y - ccorrect) = functionlogic;
        end
    end


end

function score = bwmatch(W, T)
    score = sum((W(:) & T(:)) | (~(W(:) | T(:)))) / numel(T);
end

function score = graymatch(W, T)
    score = sqrt(sum(T(:).^2) * sum(W(:).^2));
end

function H = myhistogram(img)

    if strcmp(class(img), 'uint8') ~= 0
       img = uint8(img); 
    end
    
    totals = zeros(1, 2^8);
    for i = 1:length(totals)
        totals(i) = sum(img(:) == (i - 1));
    end
    
    H = totals;
end

