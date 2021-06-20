% 对三个通道分别进行中值滤波，转换为灰度图像
function img_gray = preprocess(img)
for i =1:3
   img_med(:,:,i)=medfilt2(img(:,:,i),[3,3]);
end
img_gray = rgb2gray(img_med);
end

