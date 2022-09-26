function output = myCDF(image)

output=zeros(256,1);

% todo

dimX = size(image, 1);
dimY = size(image, 2);

histogram=zeros(256, 1);
for i = 1 : dimX
    for j = 1 : dimY
        histogram(image(i, j) + 1) = histogram(image(i, j) + 1) + 1;
    end
end

output(1) = 255*histogram(1)/(dimX * dimY) - 1;

for i = 2 : 256
    output(i) = output(i-1) + 255*histogram(i)/(dimX * dimY);
end