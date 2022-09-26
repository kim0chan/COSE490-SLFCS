function output = myAHE(input, numtiles)

dimX = size(input,1);
dimY = size(input,2);

output = uint8(zeros(dimX,dimY));

% ToDo

stepSizeX = ceil(dimX / numtiles(1));
stepSizeY = ceil(dimY / numtiles(2));

localHE = uint8(zeros(dimX, dimY));

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
        localHE(startX:endX, startY:endY) = myHE(tempImage);
        
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
                intensity = localHE(i, j);
            elseif j > dimY - ipY
                intensity = localHE(i, j);
            else
                intensity = 128;
            end
        elseif i > dimX - ipX
            if j <= ipY
                intensity = localHE(i, j);
            elseif j > dimY - ipY
                intensity = localHE(i, j);
            else
                intensity = 128;
            end
        elseif j <= ipY
            intensity = 128;
        elseif j > dimY - ipY
            intensity = 128;
        else
            intensity = 64;
        end

        output(i, j) = intensity;
    end
end

end