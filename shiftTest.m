%shiftTest.m

clear all
close all
clc 

I = im2double(imread('Apple1.jpg'));
G = rgb2gray(I);

size(G); %for testing purposes

%no blur image
imageA = image1fn(G)

%Some blur image
imageB = image2fn(G)

%Lots of blur image
imageC = image3fn(G)

comparefn(imageA,imageB,imageC);
%-----------------------------------------------------------------------------