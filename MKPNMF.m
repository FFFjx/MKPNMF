function [ W_phi,beta, err,K] = MKPNMF( dataset_X,rank,gamma )
%The main part of the MKPNMF algorithm

%% Set the max iteration and the convergence threshold
max_itr=100;
epsilon=0.001;
%% Initialize W_phi and other variables
r=rank;
[~,n]=size(dataset_X);
W_phi=rand(n,r);
[~,m]=size(gamma);
err = [1,max_itr];
[Kernel_cell]=kernel_function(dataset_X,gamma);
%% Start the iteration
for current_itr=1:max_itr;
    t=zeros(1,m);
    for jj=1:m
        %Corresponding to the formula(8) in the paper
        t(1,jj)=trace((eye(n)-W_phi*W_phi')*((eye(n)-W_phi*W_phi')')*...
            Kernel_cell{1,jj});
    end
    %% To obtain coefficient vector of kernel function beta
    %Use liner programming
    %Corresponding to the formula(9) in the paper
    c=t';
    Aeq=ones(1,m);
    beq=1;
    [x,~]=linprog(c,[],[],Aeq,beq,zeros(m,1));
    beta=x';
    
    %% Gain the combination of kernel function
    K=zeros(n,n);
    for jj=1:m
        %Corresponding to the formula(4) in the paper
        K=K+Kernel_cell{1,jj}*beta(1,jj);
    end 
    %% Gain W_phi by iteration calculation
    for i=1:n
        %Corresponding to the formula(12) in the paper
        temp = (W_phi*W_phi'*K*W_phi+K*(W_phi*W_phi')*W_phi);
        coefficient=(K(i,:)*W_phi)./temp(i,:);
        W_phi(i,:) = 2*W_phi(i,:).*coefficient; 
        %Notice!There is something wrong with the derivation process from
        %formula(11) to formula(12) in the paper.The correct result is:
        %-4KW_phi+2(W_phiW_phi'K+KW_phiW_phi'W_phi)+lambda=0, which leads to
        %the iterative formula of W_phi is supposed to *2
    end
    
    %Calaulte the convergence condition, refer to the formula(3) in the
    %paper
    convergence_condition=sqrt(trace((eye(n)-W_phi*W_phi')*...
        ((eye(n)-W_phi*W_phi')')*K));
    
    err(1,current_itr) = convergence_condition;
    if convergence_condition<=epsilon
        break;
    end
end
end

