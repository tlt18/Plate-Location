% 字符识别
function [result,img_reshaped] = recognition(img_sub,img_ref0,img_ref1,img_ref2,img_ref3,img_ref4,img_ref5,img_ref6 ...
    ,img_ref7,img_ref8,img_ref9)
[height,width] = size(img_ref0);
img_reshaped = 1- img_sub;
img_reshaped = imresize(img_reshaped,[height,width]);

img_reshaped(find(img_reshaped>0.5))=1;
img_reshaped(find(img_reshaped<=0.5))=0;

se = strel('rectangle',[3 3]);
img_reshaped = imerode(img_reshaped,se);

IOU = zeros(1,10);
I_list = zeros(1,10);
same_list = zeros(1,10);
for n = 1:10
    U = 0;
    I = 0;
    s = 0;
    eval(['img_ref','=','img_ref',num2str(n-1),';']);
    for h = 1:height
        for w = 1:width
            if(img_reshaped(h,w)==1 || img_ref(h,w)==1)
                U = U+1;
            end
            if(img_reshaped(h,w)==1 && img_ref(h,w)==1)
                I = I+1;
            end
            if(img_reshaped(h,w)==img_ref(h,w))
                s = s+1;
            end
        end
    end
    IOU(1,n) = I/U;
    I_list(1,n) = U;
    same_list(1,n) = s;
end
[~,result] = max(IOU);

result = result - 1;

end

