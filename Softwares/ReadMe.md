#Softwares
#该文件夹下包含了一些Image Quality Assessment(IQA) 和 Video Quality Assessment(VQA)的代码

##psnr.m
  psnr计算程序——MATLAB

##ssim.m
  SSIM计算程序——MATLAB

##vif.m
  vif计算程序——MATLAB(是我们实验室自己实现的，可以用作参考；标准的VIF代码请在LearnMore中获取)

##LR-IQA
  该文件夹下包含了实验室自己提出的IQA模型，效果较为优秀：
  lr-iqa.m:		主函数，计算两幅图像的LR得分
  image2patch.m:	子函数，将图像reshape成适合进行训练的格式
  patch2image.m:	子函数，将训练数据复原成图像

##PCA-IQA.m
  自己实现的基于主成分分析的IQA，效果不是很理想，不过可以作为参考

##pfm-in-LIVE.m
  测试算法在LIVE数据库中效果的脚本

##test-sparse.m
  稀疏矩阵相关函数的使用demo（无注释）

##train-bpp.m
  BP神经网络训练demo（无注释）

##LearMore.txt
  德州大学奥斯汀分校的视频质量评价实验室主页，包含该实验室自己设计并实现的多种评价方法和论文