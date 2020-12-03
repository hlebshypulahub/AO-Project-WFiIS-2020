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


%%% Hough find circles
[centers, radii] = imfindcircles(Im, [6 20],...
    'ObjectPolarity', 'bright', 'Method', 'TwoStage',...
    'Sensitivity', 0.89, 'EdgeThreshold', 0.18);
subplot(1,2,1);
imshow(Im);
viscircles(centers, radii, 'EdgeColor', 'b', 'LineWidth', 1);


%%% Scatter of centers
% subplot(1,2,1);
% scatter(centers(:,1), centers(:,2), 'MarkerFaceColor', [0 0 1]);

[m, n] = size(centers);

[idx, isNoise] = DBSCAN(centers, 130, 60);

% countLog = sum(isNoise==0);

% arrLog = zeros(countLog, 2);

% subplot(1,2,2);
% for i=1:m
%    if (isNoise(i) == 0)
%       scatter(centers(i,1), centers(i,2),...
%           'MarkerFaceColor', [0 0 1]);
%       hold on;
%    end
% end

arrLog = zeros(0,2);
arrRad = zeros(0,1);
index = 1;

for i=1:m
   if (isNoise(i) == 0)
      arrLog(index, 1) = centers(i,1);
      arrLog(index, 2) = centers(i,2);
      arrRad(index) = radii(i);
      index = index + 1;
   end
end

subplot(1,2,2);
imshow(Im);
viscircles(arrLog, arrRad, 'EdgeColor', 'b', 'LineWidth', 1);



























