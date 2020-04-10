function Metricfn = BisectionMetricFunciton(Region)

    [W, H, dim] = size(Region);
    [Rx,Ry] = imgradientxy(Region);
    [Rmag,Rdir] = imgradient(Rx,Ry);
    
    F = 0;
    
    for c = 1:W;
        for r = 1:H;
            F = Rmag(c,r) + F;  %sums all the Edge numbers
        end
    end
    Metricfn = [F];
end






