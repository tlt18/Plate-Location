function img_area_new = accurate_select(img_area,color)
if(color == 1)
    color_range = [0.55,0.73];
elseif(color ==2 )
    color_range = [0.04,0.30];
else
    img_area_new = img_area;
    return 
end
hsv = rgb2hsv(img_area);
[height,width,~] = size(hsv);
h_judge = zeros(height,width);
for h=1:height
    for w=1:width
        h_judge(h,w) = (hsv(h,w,1)>color_range(1)) && (hsv(h,w,1)<color_range(2));
    end
end
proportion_row = sum(h_judge,2)/width;
proportion_row = medfilt1(proportion_row,4);
proportion_col = sum(h_judge,1)/height;
proportion_col = medfilt1(proportion_col,4);
row_judge = find(proportion_row>0.7);
if isempty(row_judge)
    index_up = 1;
    index_down = h;
elseif (row_judge(end)-row_judge(1))/h>0.5
    index_up = row_judge(1);
    index_down = row_judge(end);
else
    index_up = 1;
    index_down = h;
end
proportion_col = proportion_col/max(proportion_col);
col_judge = find(proportion_col>0.77);
if isempty(col_judge)
    index_left = 1;
    index_right = w;
elseif (col_judge(end)-col_judge(1))/w>0.5 && (col_judge(end)-col_judge(1))>(index_down-index_up)*(440/140-1)
    index_left = col_judge(1);
    index_right = col_judge(end);
else
    index_left = 1;
    index_right = w;
end
    img_area_new = img_area(index_up:index_down,index_left:index_right,:);
end

