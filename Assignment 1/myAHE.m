function output = myAHE(input, numtiles)

dimX = size(input,1);
dimY = size(input,2);

output = uint8(zeros(dimX,dimY));

% ToDo

stepSizeX = ceil(dimX / numtiles(1));
stepSizeY = ceil(dimY / numtiles(2));

cdfs = zeros(256, 1, numtiles(1), numtiles(2));

% Local Histogram Section
for i = 1 : numtiles(1)
    startX = (i - 1) * stepSizeX + 1;
    endX = startX + stepSizeX - 1;
    if dimX < endX
            endX = dimX;
    end
    for j = 1 : numtiles(2)
        startY = (j - 1) * stepSizeY + 1;
        endY = startY + stepSizeY - 1;
        if dimY < endY
            endY = dimY;
        end
        
        tempImage = input(startX:endX, startY:endY);
        cdfs(:, :, i, j) = myCDF(tempImage);
    end
end

ipX = floor(stepSizeX / 2);
ipY = floor(stepSizeY / 2);
% Output Image Section
for i = 1 : dimX
    for j = 1 : dimY
        % Checking if current pixel is on the corner
        if i <= ipX
            if j <= ipY
                % left top
                intensity = cdfs(input(i, j) + 1, 1, 1, 1);
            elseif j > dimY - ipY
                % right top
                intensity = cdfs(input(i, j) + 1, 1, 1, numtiles(2));
            else
                % top
                WEST = cdfs(input(i, j) + 1, 1, 1, ceil((j-ipY)/stepSizeY));
                EAST = cdfs(input(i, j) + 1, 1, 1, ceil((j-ipY)/stepSizeY) + 1);
                distanceW = mod(j-ipY, stepSizeY);
                distanceE = stepSizeY - distanceW;
                intensity = WEST*distanceE/stepSizeY + EAST*distanceW/stepSizeY;
            end
        elseif i > dimX - ipX
            if j <= ipY
                % left bottom
                intensity = cdfs(input(i, j) + 1, 1, numtiles(1), 1);
            elseif j > dimY - ipY
                % right bottom
                intensity = cdfs(input(i, j) + 1, 1, numtiles(1), numtiles(2));
            else
                % bottom
                intensity = 128;
            end
        elseif j <= ipY
            % left
            intensity = 128;
        elseif j > dimY - ipY
            % right
            intensity = 128;
        else
            % middle
            intensity = 64;
        end

        output(i, j) = intensity;
    end
end

end