%comparefn.m

function comparefn = comparefn(imageA,imageB,imageC)
        if abs(imageA - imageB) > abs(imageB - imageC)
           disp("Image is between A and B")
        else
           disp("Image is between B and C")
        end
end
%-----------------------------------------------------------------------------