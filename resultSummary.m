clear;clc;
load('PaviaU.mat')
[x,y,~]=size(paviaU);
D1=reshape(paviaU,size(paviaU,1)*size(paviaU,2),1,size(paviaU,3));
D1=reshape(D1,size(D1,1),size(D1,3));
D1=mat2gray(D1);
rank=10;
lambda=5;
[ W1,H1,err1 ] = ONMF( D1,rank,lambda );
[ W2,H2,err2 ] = NMF( D1,rank );
load('PaviaU_gt.mat')
for r=1:rank
    D_=paviaU_gt;
    %The paviaU_gt matrix has 10 labels(0-9), set each label to 12(or
    %larger) to reveal each cluster. The larger one makes the outcome more
    %obvious.
    D_(D_==r-1)=12;
    subplot(3,rank,r);imshow(D_,[]);
end
for r=1:rank
    W_=reshape(W1(:,r),x,y);
    subplot(3,rank,r+rank);imshow(W_);
end
for r=1:rank
    W_=reshape(W2(:,r),x,y);
    subplot(3,rank,r+2*rank);imshow(W_);
end