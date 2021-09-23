function [ Kernel_cell ] = kernel_function( dataset_X,gamma )
%Given the processed dataset_X and multi-kernel function's parameters to
%get multi-kernel matrices, which are stored in a cell

%gamma denotes the set of the multi-kernel function's parameters 
[~,n]=size(dataset_X);
[~,m]=size(gamma);
Kernel_cell=cell(1,m);
%% Calculate the variance of the dataset_X
X_mean=mean(dataset_X,2);
X_variance=0;
for xx=1:n
    X_variance=X_variance+((norm(dataset_X(:,xx)-X_mean,2))^2)/n;
end
%% Calculate the multi-kernel matrices
%Here, we use Gaussian Kernel Function
for xx=1:m
    kernel=zeros(n,n);
    for p=1:n
        for q=1:n
            Norm=(norm(dataset_X(:,p)-dataset_X(:,q),2));
            kernel(p,q)=exp(-Norm/10/(gamma(1,xx)*X_variance));
        end
    end
    Kernel_cell{1,xx}=kernel;
end
end

