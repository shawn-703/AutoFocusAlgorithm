% image1fn

function image1fn = image1fn(G)
        [Gx,Gy] = imgradientxy(G);

        [Gmag,Gdir] = imgradient(Gx,Gy);

        sum1 = 0;
        for c = 1:480;
            for r = 1:853;
                sum1 = Gmag(c,r) + sum1; 
            end
        end
        image1fn = (sum1);
end
%-----------------------------------------------------------------------------