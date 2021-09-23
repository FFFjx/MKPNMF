clear;clc;

%Load the dataset and preprocess it
load('PaviaU.mat')
[x,y,~]=size(paviaU);
D1=reshape(paviaU,size(paviaU,1)*size(paviaU,2),1,size(paviaU,3));
D1=reshape(D1,size(D1,1),size(D1,3));
D1=mat2gray(D1);

%Set rank to 10. This dataset has 10 labels(0-9) in ground truth
rank=10;
t0=cputime;
[ W_NMF,H_NMF,err_NMF ] = NMF( D1,rank );
t_NMF=cputime-t0;

lambda=5;
t0=cputime;
[ W_ONMF,H_ONMF,err_ONMF ] = ONMF( D1,rank,lambda );
t_ONMF=cputime-t0;

gamma=[1/32 1/16 1/8 1/4 1/2 1 2 4 8 16 32];
t0=cputime;
[ W_phi,beta,err,K] = MKPNMF( D1,rank,gamma );
t_MKPNMF=cputime-t0;

Y=[t_NMF,t_ONMF,t_MKPNMF];
X={'NMF','ONMF','MKPNMF'};
bar(Y)
set(gca,'XTickLabel',X)
xlabel('Algorithms');
ylabel('Runtime(second)'); 