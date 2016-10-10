function PSNR = mse(f1, f2)
%计算两幅图像的峰值信噪比
k = 8;
%k为图像是表示地个像素点所用的二进制位数，即位深。
fmax = 2.^k - 1;
a = fmax.^2;
e = double(f1) - double(f2);
[m, n] = size(e);
e=e(:);
PSNR = sum(e.^2)/(m*n);
