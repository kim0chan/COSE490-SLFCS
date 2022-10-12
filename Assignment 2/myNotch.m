input=imread('cat-halftone.png');

figure,imshow(input);
title('Input Image');

% Get size
dimX = size(input,1);
dimY = size(input,2);

% Convert pixel type to float
[f, revertclass] = tofloat(input);

% Determine good padding for Fourier transform
PQ = paddedsize(size(input));

% Fourier tranform of padded input image
F = fft2(f,PQ(1),PQ(2));
F = fftshift(F);
figure,imshow(log(1+abs((F))), []);

% -------------------------------------------------------------------------

%
% Creating Frequency filter and apply - High pass filter
%

% Parameters
n = 4;
D_0 = 40;

% Generating 1 + k*[1 - H_LP(u, v)]
% Hard-coding section.
H = ones(PQ(1), PQ(2));
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 130)^2 + (j - 832)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 554)^2 + (j - 832)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 130)^2 + (j - 192)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 554)^2 + (j - 192)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end


for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 84)^2 + (j - 513)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 601)^2 + (j - 513)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 343)^2 + (j - 126)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 343)^2 + (j - 898)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end


for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 84)^2 + (j - 126)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 600)^2 + (j - 126)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 600)^2 + (j - 898)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 84)^2 + (j - 898)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end


for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 130)^2 + (j - 58)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 554)^2 + (j - 58)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 554)^2 + (j - 966)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 130)^2 + (j - 966)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end


for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 176)^2 + (j - 126)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 508)^2 + (j - 126)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 508)^2 + (j - 898)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 176)^2 + (j - 898)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end


for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 40)^2 + (j - 194)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 644)^2 + (j - 194)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 40)^2 + (j - 830)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 644)^2 + (j - 830)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end


for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 298)^2 + (j - 194)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 386)^2 + (j - 830)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 298)^2 + (j - 830)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 386)^2 + (j - 194)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end


for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 130)^2 + (j - 582)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 554)^2 + (j - 442)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 130)^2 + (j - 442)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 554)^2 + (j - 582)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end


for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 176)^2 + (j - 512)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - 508)^2 + (j - 512)^2);
        H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
        H(i, j) = H(i,j)-H_LP_uv;
    end
end


% Generating F
F = F .* H;


% Printing H (!FOR REPORT!)
figure, imshow(H);

% Printing F (!FOR REPORT!)
figure, imshow(log(1+abs((F))), []);


%
% ToDo
%
G = F; 

% -------------------------------------------------------------------------

% Inverse Fourier Transform
G = ifftshift(G);
g = ifft2(G);

% Revert back to input pixel type
g = revertclass(g);

% Crop the image to undo padding
g = g(1:dimX, 1:dimY);

figure,imshow(g, []);
title('Result Image');