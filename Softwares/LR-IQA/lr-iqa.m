function [sc1,sc2]=lr-iqa(path1,path2,B)
%%该函数用来计算LR-IQA指标
%%input
%%@path1：原始图片路径
%%@path2：失真图片路径
%%@B:分块大小
%%output
%%@sc1:学习网络和无失真学习网络的相似度
%%@sc2:预测误差

    X=imread(path1);
    Y=imread(path2);
    %%转为灰度图
    X=rgb2gray(X);
    Y=rgb2gray(Y);
    %%double便于后来计算
    X=double(X);
    Y=double(Y);
  
    %%宽高要取B的整数倍
    [hh ww]=size(X);
    hh=floor(hh/B)*B;
    ww=floor(ww/B)*B;
   
    X=X(1:hh,1:ww);
    Y=Y(1:hh,1:ww);
   
    
   
    [x hh ww]=img2patch(X,B);
    [y hh ww]=img2patch(Y,B);
    %%获取训练样本的个数
    lenx=size(x,1);
    
    mx=mean(x);
    my=mean(y);
    mx=repmat(mx,[lenx,1]);%%repmat也是常用函数
    my=repmat(my,[lenx,1]);
   
    %%进行训练时一般要减去图像的均值
    x=x-mx;
    y=y-my;
    
    %%最小二乘法推导得出
    w=inv(x'*x)*x'*y;
    
    %%dy为重建图像
    dy=x*w;
 
    %%其实可以不用变换回来直接计算mse，这里时为了重建图像的可视化。
    dyimg=patch2img(dy,hh,ww,B);
    yyimg=patch2img(y,hh,ww,B);
    cw=w(1:B*B,1:B*B);
    cw=cw(:);
    cI=eye(B*B);
    cI=cI(:);
    len1=sqrt(cw'*cw);
    len2=sqrt(cI'*cI);
    sc1=(cw'*cI)/(sqrt(cw'*cw)*sqrt(cI'*cI)*(abs(sqrt(cw'*cw)-sqrt(cI'*cI))+1));
    
    
    sc2=mse(dyimg,yyimg);
  
    if sc2<=2
        sc2=0;
    end
    
    
  
end