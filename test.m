clear; clc;


%%% Obraz oryginalny
origIm = double(imread('test.jpg'))/255;
Im = origIm;
% imshow(Im);


%%% Obraz w odcieniach szarości
gIm = rgb2gray(Im);
Im = gIm;
% figure;
% imshow(Im);


%%% Filtr medianowy
medIm = medfilt2(Im, [2 2]);
Im = medIm;
% figure;
% imshow(Im);


%%% Filtr Gaussa
f = fspecial('gaussian', [3 3], 10);
gaussIm = imfilter(Im, f);
Im = gaussIm;
% figure;
% imshow(Im);
% imhist(gaussIm);


%%% Kontrast
c = 1.26;
contIm = Im * c;
contIm(contIm<0) = 0;
contIm(contIm>1) = 1;
Im = contIm;
% figure;
% imshow(Im);


%%% Gamma korekcja
gamma = 0.45;
gammaIm = Im.^(1/gamma);
gammaIm(gammaIm<0) = 0;
gammaIm(gammaIm>1) = 1;
Im = gammaIm;
% figure;
imshow(Im);




























