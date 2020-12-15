clear; clc;


%%% Obraz oryginalny
origIm = double(imread('img/1.jpg'))/255;
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
c = 1.4;
contIm = Im * c;
contIm(contIm<0) = 0;
contIm(contIm>1) = 1;
Im = contIm;
% figure;
% imshow(Im);


%%% Gamma korekcja
gamma = 1.2;
gammaIm = Im.^(1/gamma);
gammaIm(gammaIm<0) = 0;
gammaIm(gammaIm>1) = 1;
Im = gammaIm;
% figure;
imshow(Im);


%%% Hough find circles
% 'ObjectPolarity', 'bright'
[centers, radii] = imfindcircles(Im, [16 50],...
    'Method', 'TwoStage',...
    'Sensitivity', 0.896, 'EdgeThreshold', 0.17);
subplot(1,2,1);
imshow(Im);
viscircles(centers, radii, 'EdgeColor', 'b', 'LineWidth', 1);


%%% DBSCAN filters found cirlces and finds logs
n = size(centers, 1);

isLog = DBSCAN(centers, 195, 26);

k = sum(isLog(:) == 1);

arrLog = zeros(k,2);
arrRad = zeros(k,1);
index = 1;

for i=1:n
   if (isLog(i) == 1)
      arrLog(index, 1) = centers(i,1);
      arrLog(index, 2) = centers(i,2);
      arrRad(index) = radii(i);
      index = index + 1;
   end
end

subplot(1,2,2);
imshow(Im);
viscircles(arrLog, arrRad, 'EdgeColor', 'b', 'LineWidth', 1);



























