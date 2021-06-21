clc;clear;close all;
img1 = imread('images\01.jpg');
img2 = imread('images\02.jpg');
img3 = imread('images\03.jpg');
img4 = imread('images\04.jpg');
img5 = imread('images\05.jpg');
img6 = imread('images\06.jpg');
img7 = imread('images\07.jpg');
img8 = imread('images\08.jpg');
img9 = imread('images\09.jpg');
img10 = imread('images\10.jpg');
img11 = imread('images\11.jpg');
img12 = imread('images\12.jpg');
img13 = imread('images\13.jpg');
img14 = imread('images\14.jpg');
img15 = imread('images\15.jpg');
img16 = imread('images\16.jpg');
color_list = [2,1,1,1,1,1,1,1,2,2,2,2,2,1,1,1];
for img_num =1:16
eval(['img=img',num2str(img_num),';']);
% 蓝色背景1，黄色背景2，其他3
color = color_list(img_num);
% imshow(img);title('原始图像');

img_gray = preprocess(img);
% figure()
% imshow(img_gray);title("灰度图像");

[sobel_vertical,Prewitt_vertical,Roberts_vertical,log_vertical,Canny_vertical] = edge_detect(img_gray);
img_edge = Prewitt_vertical;
% imshow(img_edge);title("edge");

% imshow(sobel_vertical);title("sobel");;
% figure()
% imshow(Prewitt_vertical);title("Prewitt");
% figure()
% imshow(Roberts_vertical);title("Roberts");
% figure()
% imshow(log_vertical);title("log");
% figure()
% imshow(Canny_vertical);title("Canny");

[img_morphology,bw_close,bw_remvoe,bw_open] = morphology(img_edge,1000);
% imshow(img_morphology);
% imshow(bw_close);title("close");
% figure()
% imshow(bw_remvoe);title("remove");
% figure()
% imshow(bw_open);title("open");
% figure()
% imshow(img_morphology);title("morphology");

img_morphology = judge(img_morphology,img);
% figure();
% imshow(img_morphology);

img_area = area_select(img_morphology,img,color);
% imshow(img_area);


img_correction = correction(img_area);
% imshow(img_correction);
% figure()
img_area_new = accurate_select(img_correction,color);
% imshow(img_area_new);

[img_final,result_list,number_list,img_reshaped_list] = segmentation(img_area_new);

% imshow(img_final);title("final");
% imshow(number_list*255);title("list");
% imshow(img_reshaped_list);title("result");

imwrite(img_area_new,['./result/定位',num2str(img_num),'.png']);
imwrite(img_final,['./result/分割',num2str(img_num),'.png']);
imwrite(img_reshaped_list,['./result/识别',num2str(img_num),'.png']);

result_list
end
