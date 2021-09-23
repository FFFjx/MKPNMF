clear;clc;
load('PaviaU_gt.mat')
for r=1:10
    D_=paviaU_gt;
    %The paviaU_gt matrix has 10 labels(0-9), set each label to 12(or
    %larger) to reveal each cluster. The larger one makes the outcome more
    %obvious.
    D_(D_==r-1)=12;
    subplot(1,10,r);imshow(D_,[]);
end
