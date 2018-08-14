clear;clc;close
load('im.mat')
newim(59:88,99:205)=25;
[imlen,imhigh]=size(newim);
a=8; %大分块长度
a2=2;%小分块长度
newi=1; %大分块置乱的起始位置
newj=1; %小分块置乱的起始位置
%%
indx=[newi:imlen/a*(imhigh/a), 1:newi-1]; %大分块置乱后的排序
indx2=[newj:(a/a2)^2, 1:newj-1]; %小分块置乱后的排序
k=-1;
for i=1:a2:imhigh
    new1(floor(i/a2)*imlen+1:ceil(i/a2)*imlen,:)=newim(i:i+a2-1,:)'; %置乱图像拆分成临时图像矩阵
end

smat=uint8(zeros(a2,a2,(a/a2)^2,imlen/a*(imhigh/a))); %储存小分块 4维矩阵 a2*a2*小块序号*大块序号
k=-1;
for i=1:size(smat,3)
    for j=1:size(smat,4)
        k=k+1;
        smat(:,:,indx2(i),indx(j))=new1(k*a2+1:(k+1)*a2,1:a2); 
    end
end

temp_mat=uint8(zeros(a)); %储存大分块
for i2=1:size(smat,4)
    k=0; %序号标记
    for i=1:a2:a
        for j=1:a2:a
            k=k+1;
            %             tmat(:,:,k)=temp_mat(i:i+a2-1,j:j+a2-1,i2);
            temp_mat(i:i+a2-1,j:j+a2-1,i2)=smat(:,:,k,i2);
        end
    end
end

%% 复原
k=0; %序号标记
for i=1:a:imlen
    for j=1:a:imhigh
        k=k+1;
        im(i:i+a-1,j:j+a-1)=temp_mat(:,:,indx(k));
    end
end
subplot(121)
imshow(newim)
subplot(122)
imshow(im)