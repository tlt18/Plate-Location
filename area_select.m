% 区域选择
function I = area_select(img_morphology,img,color)
stats = regionprops(img_morphology,'BoundingBox','Centroid');
centroids = cat(1,stats.Centroid);
L = length(stats);
% hold on
% for i = 1:L
% text(centroids(i,1),centroids(i,2),num2str(i))
% plot(centroids(i,1),centroids(i,2),'r*')
% end
% hold off
fprintf("车牌候选区域的数量:%d \n", L);

index_area = area_judge(stats)
index_color = color_judge(stats,img,color)
index_ratio = ratio_judge(stats)
index_sum = index_area+index_color*1.5+index_ratio
[~,index] = max(index_sum);

bb = stats(index).BoundingBox;
I = img(floor(bb(2))+1:floor(bb(2)+bb(4)),floor(bb(1))+1:floor(bb(1)+bb(3)),:);
% figure(9);imshow(I); title("车牌")
end

function index_list = area_judge(stats)
index_list = zeros(1,length(stats));
for i=1:length(stats)
    bb = stats(i).BoundingBox;
    area = bb(4) * bb(3);
    if  area<20000&&area>2000
        index_list(i)=1;
    end
end
end

function index_list = color_judge(stats,img,color)
index_list = zeros(1,length(stats));
proportion_list = zeros(1,length(stats));
% 色调H：红色为0°，绿色为120°,蓝色为240°,MATLAB的h归一化到1
if(color == 1)
    color_range = [0.55,0.73];
elseif(color ==2 )
    color_range = [0.08,0.24];
else
    return 
end
for i=1:length(stats)
    bb = stats(i).BoundingBox;  % 取预判断的区域
    I=img(floor(bb(2))+1:floor(bb(2)+bb(4)),floor(bb(1))+1:floor(bb(1)+bb(3)),:);
%     figure(8); imshow(I);
    hsv = rgb2hsv(I);
    [height,width,~] = size(hsv);
    count = 0;  % 统计蓝色像素值的数量
    for h=1:height
        for w=1:width
            h_judge = (hsv(h,w,1)>color_range(1)) && (hsv(h,w,1)<color_range(2));
            if h_judge
                count = count + 1;
            end
        end
    end
    pixel_sum = width*height;
    proportion_list(i)=count/pixel_sum;
end
% match_num = ceil(length(stats)*0.2);
% Arraycopy = proportion_list;
% for j = 1:match_num
%    [~, Index] = max(Arraycopy);
%    index_list(Index)=1;
%    Arraycopy(Index) = 0;
% end
index_list = proportion_list/max(proportion_list);
end

function index_list = ratio_judge(stats)
index_list = zeros(1,length(stats));
for i=1:length(stats)
    bb = stats(i).BoundingBox;
    r = bb(3)/bb(4); 
    ratio_std = 440/140;
    if (r>ratio_std-1.1) && (r<ratio_std+2)
        index_list(i)=1;
    end
end
end


