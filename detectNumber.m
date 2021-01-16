clc; clear;

im = imresize(double(imread('myEx.jpg'))/255, [1000 NaN]);
gim = rgb2gray(im);
%%%%1%%%%%
figure;
imshow(gim);

[level,E] = graythresh(gim);
BW = imbinarize(gim, level);
% %%%%2%%%%%
figure;
imshow(BW);

im_fill = imfill(BW, 'holes');
%%%%3%%%%%
figure;
imshow(im_fill);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
im_fill2 = bwareaopen(im_fill, 100);
%%%%8%%%%%
figure;
imshow(im_fill2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
props = regionprops(im_fill2,'BoundingBox', 'Orientation', 'EulerNumber', 'Area');
%%%9%%%%%
imshow(im_fill2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index = [];

for i = 1:size(props, 1)
    upper_left_x = props(i).BoundingBox(1);
    upper_left_y = props(i).BoundingBox(2);
    width = props(i).BoundingBox(3);
    height = props(i).BoundingBox(4);     
    ratio = width/height;
    if  props(i).Area > 1600 && ratio <= 5 && ratio >= 3 &&  upper_left_y > 750 && props(i).Orientation > -5 && props(i).Orientation < 5 &&  props(i).EulerNumber == 1 
        index = [index, i];
        disp(['ratio = ', num2str(ratio)])
        disp(['I = ', num2str(i)])
    end
end

figure, imshow(im);
hold on;
for i = 1:size(index, 2)
    upper_left_x = props(index(i)).BoundingBox(1); 
    upper_left_y = props(index(i)).BoundingBox(2);
    width = props(index(i)).BoundingBox(3); 
    height = props(index(i)).BoundingBox(4);
    upper_right_x = upper_left_x + width;
    upper_right_y = upper_left_y;
      
    line([upper_left_x upper_right_x],[upper_left_y upper_right_y],'LineWidth', 3, 'Color','red');
    line([upper_right_x upper_right_x],[upper_right_y upper_right_y+height],'LineWidth', 3, 'Color','red');
    line([upper_right_x upper_left_x],[upper_right_y+height upper_right_y+height],'LineWidth', 3, 'Color','red');
    line([upper_left_x upper_left_x],[upper_right_y+height upper_left_y],'LineWidth', 3, 'Color','red');
end
hold off;









