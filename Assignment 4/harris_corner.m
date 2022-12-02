%
% Skeleton code for COSE490 Fall 2022 Assignment 4
%
% Won-Ki Jeong (wkjeong@korea.ac.kr)
%

clear all;
close all;

%
% Loading input image
%
I=imread('building-600by600.tif');
%I=imread('checkerboard-noisy2.tif');
%I = medfilt2(I, [5 5]);
Img=double(I(:,:,1));


%
% ToDo: Compute R
%
[numRows,numCols] = size(Img);
[xgrad, ygrad] = gradient(Img);

xxgrad = xgrad .^ 2;
yygrad = ygrad .^ 2;
xygrad = xgrad .* ygrad;

f = fspecial('gaussian',5,1.0);
xgrad_smth = imfilter(xxgrad, f, 'symmetric');
ygrad_smth = imfilter(yygrad, f, 'symmetric');
xygrad_smth = imfilter(xygrad, f, 'symmetric');

H = zeros(2, 2, numRows, numCols);
R = zeros(numRows, numCols);
for i = 1: numRows
    for j = 1: numCols
        H(1, 1, i, j) = xgrad_smth(i, j);
        H(1, 2, i, j) = xygrad_smth(i, j);
        H(2, 1, i, j) = xygrad_smth(i, j);
        H(2, 2, i, j) = ygrad_smth(i, j);
    end
end


k = 0.03;
sum = 0;
for i = 1: numRows
    for j = 1: numCols
        det_H = det(H(:, :, i, j));
        trace_H  = trace(H(:, :, i, j));
        R(i, j) = det_H - k * (trace_H^2);
        sum = R(i, j);
    end
end
avg = sum / (numRows * numCols);

%
% ToDo: Visualize R values using jet colormap
%

imshow(R, []);
c = jet;
colormap(c);
colorbar;

%% 

%
% ToDo: Threshold R & Collect Local Maximum Points
%

threshold = 30000 * abs(avg);

TH = zeros(numRows, numCols);
for i = 1: numRows
    for j = 1: numCols
        if R(i, j) > threshold
            TH(i, j) = 1;
        end
    end
end

masked = TH .* R;
LM = imregionalmax(masked);

%% Report Images
%imshow(TH, []);
%imshow(masked, []);
%imshow(LM, []);


%
% Example of collecting points and plot them
%
% (10,1), (15,2), (20,3)
%
%location = [10 15 20; 1 2 3]'
%points = cornerPoints(location)
%plot(points)
count = 1;
location = [0 ; 0]'
for i = 1: numRows
    for j = 1: numCols
        if LM(i, j) > 0
            location(count, 2) = i;
            location(count, 1) = j;
            count = count + 1;
        end
    end
end
points = cornerPoints(location);


%
% Visualize corner points over the input image
%

imshow(I)

hold on

plot(points)

hold off

