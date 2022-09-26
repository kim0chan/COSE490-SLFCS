function output = myHE(input)

dimX = size(input,1);
dimY = size(input,2);

output = uint8(zeros(dimX,dimY));

% ToDo
cdf_in = myCDF(input);
for i = 1 : dimX
    for j = 1 : dimY
        output(i, j) = cdf_in(input(i, j) + 1);
    end
end

end

