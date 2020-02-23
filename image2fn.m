% image2fn

function image2fn = image2fn(G)
         B = imgaussfilt(G,2);

        [Bx,By] = imgradientxy(B);

        [Bmag,Bdir] = imgradient(Bx,By);

        sum2 = 0;
        for x = 1:480;
            for y = 1:853;
                sum2 = Bmag(x,y) + sum2; 
            end
        end
        image2fn = (sum2);
end
%-----------------------------------------------------------------------------