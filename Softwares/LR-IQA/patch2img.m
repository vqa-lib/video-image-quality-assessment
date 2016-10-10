function img=patch2img(p,height,width,B)
%%patch2img将经过patch2img的图像复原回来
%%Input:
%%%@p:经过img2patch后的图像数据
%%%@height:p中不存在宽高信息，因此图像的宽高需要额外的变量指定，此处height=图像高度/B （即img2patch中的第二个输出）
%%%@width:同上
%%%@B:分块大小


pp=mat2cell(p,ones(width*height,1),ones(1,1)*B*B);
  
    
    np=cell(height,width);
    for i=1:height
        for j=1:width
            np{i,j}=pp{(j-1)*height+i};
            tmp=np{i,j};
            np{i,j}=reshape(tmp',[B,B]);%%reshape函数需要保证reshape前后指定的矩阵中的元素数量不变 e.g. 不能将3x8的矩阵reshape成4x5。matlab的reshape不会自动截取或者自动填充
        end
    end
    
    img=cell2mat(np);
    
end