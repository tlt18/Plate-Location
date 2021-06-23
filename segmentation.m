% 此函数的简短摘要。
% 此函数的详细说明。
function [img_final,result_list,number_list,img_reshaped_list] = segmentation(img_area_new)
% 如果二值化之前进行直方图均衡化
img_area_new = histeq(img_area_new);
img_licence_gray = preprocess(img_area_new);
img_licence_binary = imbinarize(img_licence_gray);
[h,w] = size(img_licence_binary);
projection = sum(img_licence_binary, 1)/h;
sum_all = sum(projection);

% 灰度反转
if(sum_all/w>0.5)
    img_licence_binary = ones(h,w)-img_licence_binary;
    projection = ones(1,w)-projection;
end

% imshow(img_licence_binary);

% 判断阈值
target_area = find(projection>0.11);

% bar(projection);
% hold on
% plot(1:w,0.11*ones(1,w),'r','linewidth',2);
% legend('灰度投影','分割阈值')

index = target_area(1);
index_list = [];
index_list(end+1) = index;
while(index<=w)
    next = index +1;
    if (ismember(next,target_area)==1)
        index = index + 1;
    else
        index_list(end+1)= index;
        index = target_area(find(target_area>index,1));
        index_size = size(index);
        if(index_size(2)~=0)
            index_list(end+1)= index;
        end
    end
end

% hold on;
% for index = index_list
%     if(mod(find(index==index_list),2)==1)
%         plot(index*ones(1,h),1:h,'r')
%     else
%         plot(index*ones(1,h),1:h,'b')
%     end
% end
hold off

num = length(index_list)/2;

img_licence_binary = ones(h,w)-img_licence_binary;
img_final = [];

img_ref0 = imread(['images\附加题\0.bmp']);
img_ref1 = imread(['images\附加题\1.bmp']);
img_ref2 = imread(['images\附加题\2.bmp']);
img_ref3 = imread(['images\附加题\3.bmp']);
img_ref4 = imread(['images\附加题\4.bmp']);
img_ref5 = imread(['images\附加题\5.bmp']);
img_ref6 = imread(['images\附加题\6.bmp']);
img_ref7 = imread(['images\附加题\7.bmp']);
img_ref8 = imread(['images\附加题\8.bmp']);
img_ref9 = imread(['images\附加题\9.bmp']);

number_list = [];
for n = 1:10
    eval(['img_ref','=','img_ref',num2str(n-1),';']);
    if (length(size(img_ref))==3)
        eval(['img_ref',num2str(n-1),'=','rgb2gray(','img_ref',num2str(n-1),')',';']);
    end
    eval(['img_ref',num2str(n-1),'(','find(','img_ref',num2str(n-1),'<=128','))=0',';']);
    eval(['img_ref',num2str(n-1),'(','find(','img_ref',num2str(n-1),'>128','))=1',';']);
    eval(['number_list=[number_list,img_ref',num2str(n-1),'];']);
end

result_list = zeros(1,num);
img_reshaped_list = [];

img_final = 0.7*ones(h,5);

for i = 1:num
%     subplot(num,1,i);
    left = index_list(2*i-1);
    right = index_list(2*i);
    img_sub = img_licence_binary(:,left:right,:);
%     imshow(img_sub);
    img_final = [img_final,img_sub,0.7*ones(h,5)];
    [result,img_reshaped] = recognition(img_sub,img_ref0,img_ref1,img_ref2,img_ref3,img_ref4,img_ref5,img_ref6,img_ref7,img_ref8,img_ref9);
    result_list(i) = result;
    eval(['img_reshaped = [img_reshaped;img_ref',num2str(result),'];']);
    img_reshaped_list = [img_reshaped_list,img_reshaped];
end
img_reshaped_list = img_reshaped_list*255;

end
