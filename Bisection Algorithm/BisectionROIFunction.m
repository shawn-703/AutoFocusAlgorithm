function [Region,n] = BisectionROIFunction(Image,n)
    persistent mask    %makes the variable permanently available
    
%initial ROIfunction runs 1 time on first focused image - select ROI
    if (n == 1)
        n = n+1;
        ROIFig = figure;
        imshow(Image)   
        title("Select Region")
        ROI = drawrectangle;    %EXTRA: add more selection shapes 
        mask = double(createMask(ROI)); %stores Region of interest
        close(ROIFig);
    end
    
%will run through code every image - changes to greyscale and crops
    G = double(rgb2gray(Image));
    Region = G.*mask;
    Region( ~any(Region,2), : ) = [];  %crops rows by removing all zeros
    Region( :, ~any(Region,1) ) = [];  %crops columns by removing all zeros
end