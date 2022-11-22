%
% Skeleton code for COSE490 Fall 2022 Assignment 3
%
% Won-Ki Jeong (wkjeong@korea.ac.kr)
%

function phi_out = levelset_update(phi_in, g, c, timestep)
phi_out = phi_in;

%
% ToDo
%

% Calculating Gradient Along X-axis.

[numRows,numCols] = size(phi_in);
xgrad = zeros(numRows, numCols);
ygrad = zeros(numRows, numCols);
for i = 1: numRows
    for j = 1: numCols
        if j == 1           % Leftmost: Forward Difference
            grad = phi_in(i, j+1) - phi_in(i, j);
        elseif j == numCols % Rightmost: Backward Difference
            grad = phi_in(i, j) - phi_in(i, j-1);
        else                % Central Difference
            grad = (phi_in(i, j+1) - phi_in(i, j-1)) / 2;
        end

        xgrad(i, j) = grad;
    end
end

% Calculating Gradient Along Y-axis.
for i = 1: numRows
    for j = 1: numCols
        if i == 1           % Topmost: Forward Difference
            grad = phi_in(i+1, j) - phi_in(i, j);
        elseif i == numRows % Bottommost: Backward Difference
            grad = phi_in(i, j) - phi_in(i-1, j);
        else                % Central Difference
            grad = (phi_in(i+1, j) - phi_in(i-1, j)) / 2;
        end

        ygrad(i, j) = grad;
    end
end


dPhi = (xgrad.^2 + ygrad.^2 + eps).^(1/2); % mag(grad(phi))
% added epsilon.

kappa = divergence(xgrad./dPhi, ygrad./dPhi); % curvature

smoothness = g.*kappa.*dPhi;
expand = c*g.*dPhi;

phi_out = phi_out + timestep*(expand + smoothness);