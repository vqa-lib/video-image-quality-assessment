clear all; 

I=imread('E:\databaserelease2\jp2k\img1.bmp');
I=rgb2gray(I);
I=double(I);

 
I2=imread('E:\databaserelease2\jp2k\img13.bmp');
I2=rgb2gray(I2);
I2=double(I2);

I2=(imresize(I2, 0.25));

I=(imresize(I, 0.25));
delI=(I-I2);
X=im2col(I,[8 8],'sliding');
X=X-repmat(mean(X),[size(X,1) 1]);
X=X ./ repmat(sqrt(sum(X.^2)),[size(X,1) 1]);

X3=im2col(delI,[8 8],'sliding');
X3=X3-repmat(mean(X3),[size(X3,1) 1]);
X3=X3 ./ repmat(sqrt(sum(X3.^2)),[size(X3,1) 1]);

X1=im2col(I,[8 8],'distinct');
X1=X1-repmat(mean(X1),[size(X1,1) 1]);
X1=X1 ./ repmat(sqrt(sum(X1.^2)),[size(X1,1) 1]);

X2=im2col(I2,[8 8],'distinct');
X2=X2-repmat(mean(X2),[size(X2,1) 1]);
X2=X2 ./ repmat(sqrt(sum(X2.^2)),[size(X2,1) 1]);



D0=GenDCTDic(64,256);
param.D=D0;
param.K=256;  % learns a dictionary with 100 elements
param.lambda=0.15;
param.numThreads=-1; % number of threads
param.batchsize=400;
param.verbose=false;

param.iter=100;  % let us see what happens after 1000 iterations.



D = mexTrainDL(X1,param);

 
%pp.L=15;
pp.eps=0;
pp.numThreads=-1;


kk1=mexOMP(X1,D, pp);
kk2=mexOMP(X2,D, pp);
delkk=mexOMP(X3,D,pp);

plot(kk1(:,1));
hold on;
plot(kk2(:,1));
