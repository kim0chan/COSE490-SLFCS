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
n = 3;
D_0 = 50;

% Generating Filter
H = zeros(PQ(1), PQ(2));

% Input suspicious noise point
n_point = 17;
suspect = zeros(n_point, 2);

suspect(1, :) = [512, 84];
suspect(2, :) = [444, 130];
suspect(3, :) = [580, 130];

suspect(4, :) = [512, 176];
suspect(5, :) = [194, 40];
suspect(6, :) = [126, 84];
suspect(7, :) = [194, 130];

suspect(8, :) = [830, 130];
suspect(9, :) = [830, 40];
suspect(10, :) = [900, 84];
suspect(11, :) = [900, 176];
suspect(12, :) = [966, 130];

suspect(13, :) = [900, 342];
suspect(14, :) = [830, 296];
suspect(15, :) = [830, 388];

suspect(16, :) = [900, 508];
suspect(17, :) = [966, 554];

for k = 1: size(suspect, 1)
    for i = 1 : PQ(1)
        for j = 1 : PQ(2)
            D = sqrt((i - suspect(k, 2))^2 + (j - suspect(k, 1))^2);
            H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
            H(i, j) = 1 - H_LP_uv;
        end
    end
    F = F .* H;
    for i = 1 : PQ(1)
        for j = 1 : PQ(2)
            D = sqrt((i - PQ(1) + suspect(k, 2))^2 + (j - PQ(2) + suspect(k, 1))^2);
            H_LP_uv = 1 / (1 + (D / D_0) ^ (2*n));
            H(i, j) = 1 - H_LP_uv;
        end
    end
    F = F .* H;
end

% Printing H (!FOR TEST!)
%figure, imshow(H);

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