
im = imread("myEx.jpg");

gim = rgb2gray(im);
fim = medfilt2(gim, [3,3]);
fim = edge(fim, 'Prewitt');
imshow(fim);


Icomp = imcomplement(fim);
hold on
[B,L] = bwboundaries(fim);
imshow(label2rgb(L))

hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1)
end
