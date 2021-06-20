% 边缘检测
function [sobel_vertical,Prewitt_vertical,Roberts_vertical,log_vertical,Canny_vertical] = edge_detect(img_gray)
sobel_vertical = edge(img_gray,'sobel','vertical'); 
Prewitt_vertical = edge(img_gray,'Prewitt',0.1,'vertical'); 
Roberts_vertical = edge(img_gray,'Roberts','vertical'); 
log_vertical = edge(img_gray,'log','vertical'); 
Canny_vertical = edge(img_gray,'Canny'); 
end

