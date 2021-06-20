% 形态学操作
function [img_morphology,bw_close,bw_remvoe,bw_open] = morphology(img_edge,remove_threshold)
se1=strel('rectangle',[1,25]);
bw_close=imclose(img_edge,se1); % 闭运算填补空洞

bw_remvoe = bwareaopen(bw_close,remove_threshold);  % 移除小对象
figure()

se2=strel('rectangle',[1,25]);
bw_open=imopen(bw_remvoe,se2); % 开运算消除突刺
figure()

se3 = strel('rectangle',[10,5]);
img_morphology = imdilate(bw_open,se3); % 膨胀
end

