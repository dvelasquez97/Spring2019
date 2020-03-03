clear
clc

%% Read In Mammogram.jpg
mam = imread('mammogram.jpg');
% imshow(mam)

%% Exercise 1
% histogram(mam)
thresh = 100; % by inspection of the histogram
result1 = mam < thresh;
result2 = windowfunction(result1, @edgedecision, 0.1);
imshow(result2)


%% Exercise 2
%T = Template Image ;
%J1 = windowfunction(result1, @match);
%J2 = Threshold J1;


%% Exercise 3



%% Functions
function finalimg = windowfunction(img, f, varargin)

    n = 3;
    [r, c] = size(img);
    finalimg = zeros(r - 2, c - 2);
    
    if ~isempty(varargin)
        b = varargin{1};
    end

    for x = 2:(r - 1)
        for y = 2:(c - 1)

            W = img((x - 1):(x + 1), (y - 1):(y + 1));
            functionlogic = f(W, n, b);

            finalimg(x, y) = functionlogic;
        end
    end

end

function edgescore = edgedecision(W, n, b)
    edgescore = (sum(W(:)) / (n^2) > (0.5 - b)) && (sum(W(:)) / (n^2) < (0.5 + b));
end

function score = match(W, T)
    score = sum((W & T) | (~(W | T))) / numel(T);
end