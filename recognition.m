% 字符识别
function [result,img_reshaped] = recognition(img_sub,img_reflist)
[height,width] = size(img_reflist);
img_reshaped = 1- img_sub;

remove = sum(img_reshaped,2);
remove_list = find(remove~=0);
img_reshaped = img_reshaped(remove_list(1):remove_list(end),:);

img_reshaped = imresize(img_reshaped,[height,NaN]);
img_reshaped(find(img_reshaped>0.5))=1;
img_reshaped(find(img_reshaped<=0.5))=0;

se = strel('rectangle',[2 2]);
img_reshaped = imerode(img_reshaped,se);
[~,w] = size(img_reshaped);

p_list = [];
for n = 1:width-w+1
   img_ref = img_reflist(:,n:n+w-1);
   s = 0;
   for i = 1:height
       for j = 1:w
            if(img_reshaped(i,j)==img_ref(i,j))
                s = s+1;
            end
       end
   end
   p_list = [p_list,s/(w*height)];
end
[~,result] = max(p_list);
result =result + w/2;
result = floor(result/20);
end

