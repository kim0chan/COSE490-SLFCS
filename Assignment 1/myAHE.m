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
                if distanceW == 0
                    % center case.
                    % Since tile size of the example is 89x89,
                    % 44th pixel in a tile is stuck in the very middle.
                    intensity = cdfs(input(i, j) + 1, 1, 1, ceil(j/stepSizeY));
                else
                    distanceE = stepSizeY - distanceW;
                    intensity = WEST*distanceE/stepSizeY + EAST*distanceW/stepSizeY;
                end
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
                WEST = cdfs(input(i, j) + 1, 1, numtiles(1), ceil((j-ipY)/stepSizeY));
                EAST = cdfs(input(i, j) + 1, 1, numtiles(1), ceil((j-ipY)/stepSizeY) + 1);
                distanceW = mod(j-ipY, stepSizeY);
                if distanceW == 0
                    % center case.
                    intensity = cdfs(input(i, j) + 1, 1, numtiles(1), ceil(j/stepSizeY));
                else
                    distanceE = stepSizeY - distanceW;
                    intensity = WEST*distanceE/stepSizeY + EAST*distanceW/stepSizeY;
                end
            end
        elseif j <= ipY
            % left
            NORTH = cdfs(input(i, j) + 1, 1, ceil((i-ipX)/stepSizeX), 1);
            SOUTH = cdfs(input(i, j) + 1, 1, ceil((i-ipX)/stepSizeX) + 1, 1);
            distanceN = mod(i-ipX, stepSizeX);
            if distanceN == 0
                % center case.
                intensity = cdfs(input(i, j) + 1, 1, ceil(i/stepSizeX), 1);
            else
                distanceS = stepSizeX - distanceN;
                intensity = NORTH*distanceS/stepSizeX + SOUTH*distanceN/stepSizeX;
            end
        elseif j > dimY - ipY
            % right
            NORTH = cdfs(input(i, j) + 1, 1, ceil((i-ipX)/stepSizeX), numtiles(2));
            SOUTH = cdfs(input(i, j) + 1, 1, ceil((i-ipX)/stepSizeX) + 1, numtiles(2));
            distanceN = mod(i-ipX, stepSizeX);
            if distanceN == 0
                % center case.
                intensity = cdfs(input(i, j) + 1, 1, ceil(i/stepSizeX), numtiles(2));
            else
                distanceS = stepSizeX - distanceN;
                intensity = NORTH*distanceS/stepSizeX + SOUTH*distanceN/stepSizeX;
            end
        else
            % middle
            NW = cdfs(input(i, j) + 1, 1, ceil((i-ipX)/stepSizeX), ceil((j-ipY)/stepSizeY));
            NE = cdfs(input(i, j) + 1, 1, ceil((i-ipX)/stepSizeX), ceil((j-ipY)/stepSizeY) + 1);
            SW = cdfs(input(i, j) + 1, 1, ceil((i-ipX)/stepSizeX) + 1, ceil((j-ipY)/stepSizeY));
            SE = cdfs(input(i, j) + 1, 1, ceil((i-ipX)/stepSizeX) + 1, ceil((j-ipY)/stepSizeY) + 1);
            
            distanceN = mod(i-ipX, stepSizeX);
            distanceS = stepSizeX - distanceN;
            distanceW = mod(j-ipY, stepSizeY);
            distanceE = stepSizeY - distanceW;

            NORTH = NW*distanceE/stepSizeX + NE*distanceW/stepSizeX;
            SOUTH = SW*distanceE/stepSizeX + SE*distanceW/stepSizeX;

            intensity = NORTH*distanceS/stepSizeY + SOUTH*distanceN/stepSizeY;
        end

        output(i, j) = intensity;
    end
end

end