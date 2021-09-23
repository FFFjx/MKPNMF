function [ W,H,err ] = ONMF( dataset_V,rank,lambda )
%The NMFOS-ED algorithm in the Reference[12]

%Set max_iteration
max_itr=200;
epsilon=0.001;

[m,n]=size(dataset_V);
r=rank;
W=rand(m,r);
H=rand(r,n);
err = [1,max_itr];
for current_itr=1:max_itr
    for i=1:r
        %Corresponding to the formula(25) in Reference[12]
        W_a=dataset_V*H';
        W_b=W*H*H';
        W(:,i)=W(:,i).*(W_a(:,i)./W_b(:,i));
        
        %Corresponding to the formula(26) in Reference[12]
        H_a=W'*dataset_V+2*lambda*H;
        H_b=W'*W*H+2*lambda*H*H'*H;
        H(i,:)=H(i,:).*(H_a(i,:)./H_b(i,:));
    end
    
    %Corresponding to the formula(16) in Reference[12]
    convergence_condition=(norm(dataset_V-W*H,'fro'))^2+...
        lambda*(norm(H'*H-eye(n,n),'fro'))^2;
    
    %Record the error
    err(1,current_itr) = convergence_condition;
    if convergence_condition<epsilon
        break;
    end
end

end

