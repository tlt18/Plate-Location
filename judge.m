% 判断是否需要直方图均衡化
function img_morphology = judge(img_morphology,img)
stats = regionprops(img_morphology,'BoundingBox','Centroid');
L = length(stats);
if L~=0
    return
else
    img_gray = preprocess(img);
img_gray = histeq(img_gray);
[sobel_vertical,Prewitt_vertical,Roberts_vertical,log_vertical,Canny_vertical] = edge_detect(img_gray);
img_edge = Prewitt_vertical;
[img_morphology,bw_close,bw_remvoe,bw_open] = morphology(img_edge,1000);
end
    
end
