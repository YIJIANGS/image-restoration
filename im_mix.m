clear;clc;close;
im=imread('lena.tif');
%%
[imlen,imhigh]=size(im);
a=8; %大分块长度
a2=2;%小分块长度
temp_mat=zeros(a); %储存大分块
k=0; %序号标记
for i=1:a:imlen
    for j=1:a:imhigh
        k=k+1;
        temp_mat(:,:,k)=im(i:i+a-1,j:j+a-1);
    end
end
%%
newi=1; %大分块置乱的起始位置
newj=1; %小分块置乱的起始位置
newim=uint8(zeros(size(im))); %新建图像矩阵
smat=uint8(zeros(a2,a2,(a/a2)^2)); %储存小分块 4维矩阵 a2*a2*小块序号*大块序号
for i2=1:length(temp_mat)
    tmat=zeros(a2); %临时储存小分块矩阵
    k=0; %序号标记
    for i=1:a2:size(temp_mat,1)
        for j=1:a2:size(temp_mat,2)
            k=k+1;
            tmat(:,:,k)=temp_mat(i:i+a2-1,j:j+a2-1,i2); 
        end
    end
    smat(:,:,:,i2)=tmat;
end

indx=[newi:length(temp_mat), 1:newi-1]; %大分块置乱后的排序
indx2=[newj:(a/a2)^2, 1:newj-1]; %小分块置乱后的排序

k=-1;
for i=1:size(smat,3)
    for j=1:size(smat,4)
        k=k+1;
        new1(k*a2+1:(k+1)*a2,1:a2)=smat(:,:,indx2(i),indx(j)); %临时图像矩阵，维度不一致
    end
end

for i=1:a2:imhigh
    newim(i:i+a2-1,:)=new1(floor(i/a2)*imlen+1:ceil(i/a2)*imlen,:)'; %填充致原图像大小
end
imshow(newim)
save('im.mat','newim')

% k=0;
% for i=1:a:imlen
%     for j=1:a:imhigh
%         k=k+1;
%         mat1=temp_mat(:,:,indx(k)); %原始大分块矩阵
%         mat2=zeros(a2); %储存小分块
%         k2=0;
%         for j2=1:a2:length(mat1)
%             for i2=1:a2:length(mat1)
%                 k2=k2+1;
%                 mat2(:,:,k2)=mat1(i2:i2+a2-1,j2:j2+a2-1);
%             end
%         end
%         k2=0;
%         for i2=1:a2:length(mat1)
%             for j2=1:a2:length(mat1)
%                 k2=k2+1;
%                 mat3(i2:i2+a2-1,j2:j2+a2-1)=mat2(:,:,indx2(k2));
%             end
%         end
%         newim(i:i+15,j:j+15)=mat3;
%     end
% end
% imshow(newim)