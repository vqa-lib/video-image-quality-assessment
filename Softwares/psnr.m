function PSNR = psnr(f1, f2)
%计算两幅图像的峰值信噪比
k = 8;
%k为图像是表示地个像素点所用的二进制位数，即位深。
fmax = 2.^k - 1;
a = fmax.^2;
e = double(f1) - double(f2);
[m, n] = size(e);
e=e(:);
b = sum(e.^2);
PSNR = 10*log(m*n*a/b);


% function sc = psnr(A, B)
% 
% 
% del=A-B;
% dd=del.*del;
% [m n]=size(A);
% N=m*n;
% MSE=sum(dd(:))/N;
% MSE=sqrt(MSE);
% sc=20*log10(255./(MSE+0.00001));
% if sc>60
%     sc=60;
% end
