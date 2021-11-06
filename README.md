# MKPNMF应用于高光谱遥感图像混元分解
## 介绍
- 高光谱遥感图像：高光谱遥感图像由航天、航空载体上的高光谱成像仪获得，它具有高光谱分辨力的特点，可在几百、上千个连续光谱波段获取目标图像。高光谱遥感
图像的主要优势是它的图像数据可视为三维图像，即二维图像加一维光谱信息。
- Multi-Kernel Projective Nonnegative Matrix Factorization：基于多核学习(Multiple Kernel Learning)的PNMF算法，相当于是KPNMF的
升级版，可以避免KPNMF的核函数选取的问题，同时相比较于MKNMF，时间性能得到提高。
## 技术用途
- 可应用于聚类、特征学习、图像分析、语音处理等领域。
## 方法实现
- NMF：传统的NMF算法，这里实现主要用于对比各个算法之间的效果和性能。
- ONMF：增加正交性约束后的NMF，这里实现主要用于对比各个算法之间的效果和性能。
- kernel_function：使用一组参数来构造一个合成的核函数，这里实现的是高斯核函数。
- MKPNMF：MKPNMF算法的主程序，首先初始化高维核空间的基矩阵$W_\phi$，然后根据$W_\phi$应用线性规划的方法求解合成核的核函数系数向量$\beta$，
使用核函数系数向量$\beta$构建合成核函数，并用于更新$W_\phi$，直到收敛或者达到最大迭代次数退出循环。
- testNMF/testONMF/testMKPNMF：使用PaviaU数据集，分别测试三种算法的结果。
- runTime：比较三种算法的运行时间并画图显示。
- resultSummary：
- PaviaU_gt：PaviaU数据集的Ground Truth。由于PaviaU数据集的大小超过25M，暂时未上传github。
## 实验结果展示
输出程序结果：  
![MKPNMF](https://github.com/FFFjx/MKPNMF/blob/main/pic/MKPNMF-err.png)  
从上图可以看到误差可以沿着迭代次数逐渐降低，直至收敛，且收敛至很小的值，趋近于零。  
下面比较三种算法的运行时间：  
![MKPNMF](https://github.com/FFFjx/MKPNMF/blob/main/pic/RunTime.png)  
从上图可以明显看出，MKPNMF的运行时间最短，ONMF次之，NMF最长，且MKPNMF的运行时间小于NMF运行时间的一半，证明MKPNMF比传统的NMF算法时间性能更优。  
## 参考论文
[1] Q.Li, L.JING and J.YU, "Multi-kernel Projective Nonnegative Matrix Factorization Algorithm," Computer Science, vol. 41,
 no. 2, pp. 64-67, 2014.  
[2] 孙莉, 赵庚星,  "基于正交非负矩阵分解的高光谱遥感图像混合像元分解," 山东农业大学学报（自然科学版）, vol. 48, no. 2, pp. 264-267, 2017.