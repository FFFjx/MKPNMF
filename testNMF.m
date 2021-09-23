clear;clc;

%Load the dataset and preprocess it
load('PaviaU.mat')
[x,y,~]=size(paviaU);
D1=reshape(paviaU,size(paviaU,1)*size(paviaU,2),1,size(paviaU,3));
D1=reshape(D1,size(D1,1),size(D1,3));
D1=mat2gray(D1);

%Set rank to 10. This dataset has 10 labels(0-9) in ground truth
rank=10;

[ W,H,err ] = NMF( D1,rank );
%The error can be plotted by using command plot(err)
for r=1:rank
    W_=reshape(W(:,r),x,y);
    subplot(1,rank,r);imshow(W_);
end