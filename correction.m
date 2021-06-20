% 正畸
function img_correction = correction(img_area)
I2 = rgb2gray(img_area);
I3 = edge(I2,'Sobel','horizontal');
% subplot(233);imshow(I3);title("边缘检测");
se = [1 1 1;1 1 1;1 1 1];
I4 = imdilate(I3,se);
% subplot(234);imshow(I4);title("膨胀");
 
[H,T,R] = hough(I4,'Theta',-89:89);
ccc = max(H);
[value, rot_theta] = max(ccc);
% rot_theta = min(rot_theta,180-rot_theta);
if rot_theta > 90
    rot_theta = rot_theta - 180;
end
img_correction = imrotate(img_area , rot_theta,'bilinear', 'loose');
end

