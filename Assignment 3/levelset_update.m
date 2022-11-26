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
xygrad = zeros(numRows, numCols);

for i = 1: numRows
    for j = 1: numCols

        if j == 1           % Leftmost: Forward Difference
            grad_x = phi_in(i, j+1) - phi_in(i, j);
        elseif j == numCols % Rightmost: Backward Difference
            grad_x = phi_in(i, j) - phi_in(i, j-1);
        else                % Central Difference
            grad_x = (phi_in(i, j+1) - phi_in(i, j-1)) / 2;
        end

        if i == 1           % Topmost: Forward Difference
            grad_y = phi_in(i+1, j) - phi_in(i, j);
        elseif i == numRows % Bottommost: Backward Difference
            grad_y = phi_in(i, j) - phi_in(i-1, j);
        else                % Central Difference
            grad_y = (phi_in(i+1, j) - phi_in(i-1, j)) / 2;
        end
        
        xgrad(i, j) = grad_x;
        ygrad(i, j) = grad_y;
    end
end

for i = 1: numRows
    for j = 1: numCols
        if j == 1           % Leftmost: Forward Difference
            grad = ygrad(i, j+1) - ygrad(i, j);
        elseif j == numCols % Rightmost: Backward Difference
            grad = ygrad(i, j) - ygrad(i, j-1);
        else                % Central Difference
            grad = (ygrad(i, j+1) - ygrad(i, j-1)) / 2;
        end

        xygrad(i, j) = grad;
    end
end

xxgrad = zeros(numRows, numCols);
yygrad = zeros(numRows, numCols);

for i = 1: numRows
    for j = 1: numCols

        if j == 1           % Leftmost: Forward Difference
            grad_xx = xgrad(i, j+1) - xgrad(i, j);
        elseif j == numCols % Rightmost: Backward Difference
            grad_xx = xgrad(i, j) - xgrad(i, j-1);
        else                % Central Difference
            grad_xx = phi_in(i, j+1) + phi_in(i, j-1) - 2.*phi_in(i, j);
        end

        if i == 1           % Topmost: Forward Difference
            grad_yy = ygrad(i+1, j) - ygrad(i, j);
        elseif i == numRows % Bottommost: Backward Difference
            grad_yy = ygrad(i, j) - ygrad(i-1, j);
        else                % Central Difference
            grad_yy = phi_in(i+1, j) + phi_in(i-1, j) - 2.*phi_in(i, j);
        end
        
        xxgrad(i, j) = grad_xx;
        yygrad(i, j) = grad_yy;
    end
end


dPhi = (xgrad.^2 + ygrad.^2 + eps).^(1/2); % mag(grad(phi))
% added epsilon.

%kappa = divergence(xgrad./dPhi, ygrad./dPhi); % curvature
kappa = dPhi.^(-3) .* (xxgrad.*ygrad.*ygrad + (-2).*xgrad.*ygrad.*xygrad + yygrad.*xgrad.*xgrad);

smoothness = g.*kappa.*dPhi;
expand = c*g.*dPhi;

phi_out = phi_out + timestep*(expand + smoothness);