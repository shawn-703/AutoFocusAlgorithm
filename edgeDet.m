clear all
close all
clc 

% I = imread('unity.jpg');
% G = rgb2gray(I);
G = imread('cameraman.tif');

size(G)

BC1 = edge(G,'Canny');
BL1 = edge(G,'log');
BS1 = edge(G,'Sobel');
BP1 = edge(G,'Prewitt');
BR1 = edge(G,'Roberts');


h=fspecial('log');
BZ1 = edge(G,'zerocross',h);

% montage({G,BC1,BL1,BS1,BP1,BR1,BZ1})


sum1 = 0;
for c = 1:256;
    for r = 1:256;
       sum1 = BZ1(c,r) + sum1; 
    end
end
disp(sum1)

B = imgaussfilt(G,2);

BC2 = edge(B,'Canny');
BL2 = edge(B,'log');
BS2 = edge(B,'Sobel');
BP2 = edge(B,'Prewitt');
BR2 = edge(B,'Roberts');


h=fspecial('log');
BZ2 = edge(B,'zerocross',h);

% montage({G,B,BC2,BL2,BS2,BP2,BR2,BZ2})

sum2 = 0;
for x = 1:256;
    for y = 1:256;
       sum2 = BZ2(x,y) + sum2; 
    end
end
disp(sum2)


W = imgaussfilt(G,5);

BC3 = edge(W,'Canny');
BL3 = edge(W,'log');
BS3 = edge(W,'Sobel');
BP3 = edge(W,'Prewitt');
BR3 = edge(W,'Roberts');


h=fspecial('log');
BZ3 = edge(W,'zerocross',h);

montage({G,W,BC3,BL3,BS3,BP3,BR3,BZ3})

sum3 = 0;
for w = 1:256;
    for z = 1:256;
       sum3 = BZ3(w,z) + sum3; 
    end
end
disp(sum1)

% montage({BS1,BP1,BR1,BL1,BZ1,BC1})
title('Montage of C, L, S, P, R, Z')
% title('Montage of the zerocrossing filtered grayscale image with some Gaussian blur')
% title('Montage of the zerocrossing filtered grayscale image with a lot of Gaussian blur')