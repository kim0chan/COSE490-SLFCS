input=imread('racing-noisy.png');

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
n = 2;
D_0 = 100;


% Calculating H
H = zeros(PQ(1), PQ(2));
for i = 1 : PQ(1)
    for j = 1 : PQ(2)
        D = sqrt((i - PQ(1)/2)^2 + (j - PQ(2)/2)^2);
        H(i, j) = 1 / (1 + (D / D_0) ^ (2*n));
    end
end

% Generating F
F = H .* F;

% Printing H (!FOR REPORT!)
figure, imshow(H);

% Printing F (!FOR REPORT!)
figure,imshow(log(1+abs((F))), []);


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