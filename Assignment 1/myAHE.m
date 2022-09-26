function output = myAHE(input, numtiles)

dimX = size(input,1);
dimY = size(input,2);

output = uint8(zeros(dimX,dimY));

% ToDo

stepSizeX = ceil(dimX / numtiles(1));
stepSizeY = ceil(dimY / numtiles(2));

localHistogram = uint8(zeros(dimX, dimY));

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
        localHistogram(startX:endX, startY:endY) = myHE(tempImage);
        
    end
end



end