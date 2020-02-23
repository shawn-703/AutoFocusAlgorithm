% image3fn

function image3fn = image3fn(G)
         B = imgaussfilt(G,5);

        [Bx,By] = imgradientxy(B);

        [Bmag,Bdir] = imgradient(Bx,By);

        sum3 = 0;
        for x = 1:480;
            for y = 1:853;
                sum3 = Bmag(x,y) + sum3; 
            end
        end
        image3fn = (sum3);
end
%-----------------------------------------------------------------------------