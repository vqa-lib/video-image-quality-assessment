function [out height width]=img2patch(Y,B)
%%image2patch将原始图像进行变形，使得变换后的图像数据更加适合进行训练
%%Input:
%%%@Y:输入图像
%%%@B:分块大小
%%%假设输入图像Y大小为[400,400],B为4，则img2patch将图像分成（400*400/（4*4））=10000个4x4大小的图像块
%%%将这些4x4的图像块reshape成1x16的行向量，再将这10000个行向量合并成一个10000x16的矩阵

%%output
%%%@out:变换后的图像
%%%@height: 图像高度/4，需要在patch2img函数中用到
%%%@width  图像宽度/4，需要在patch2img函数中用到

[m,n]=size(Y);
m=floor(m/B)*B; %%若图像的长度不是B的倍数，需要取整，floor为取整函数，e.g. floor(7.9)=7.
n=floor(n/B)*B;
Y=Y(1:m,1:n); %%将长宽取整后的图像替代原始图像
cy=mat2cell(Y,ones(m/B,1)*B,ones(n/B,1)*B);
%%mat2cell在图像分块中非常常用
%%A=[1 2 3;4 5 6;7 8 9];
%%B=mat2cell(A,[2 1],[1 2]);
%%则 B{1,1}=[1 3];B{1,2}=[2 3;5 6];B{2,1}=[7];b{2,2}={8 9};
%%可以通过help mat2cell查询所有功能
for i=1:m/B
    for j=1:n/B
        cy{i,j}=(cy{i,j}(:))';%%a(:)表示将矩阵a‘压扁’成一个列向量，方式是第一列接第二列依次类推；右上角的分号表示转置
    end
end
out=cell2mat(cy(:));%%将多个cell的元素合并成一个matrix
height=m/B;
width=n/B;
end