function [ W,H,err ] = NMF( dataset_V,rank )
%The normal NMF algorithm

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
        W_a=dataset_V*H';
        W_b=W*H*H';
        W(:,i)=W(:,i).*(W_a(:,i)./W_b(:,i));
        H_a=W'*dataset_V;
        H_b=W'*W*H;
        H(i,:)=H(i,:).*(H_a(i,:)./H_b(i,:));
    end
    
    convergence_condition=(norm(dataset_V-W*H,'fro'))^2;
    
    err(1,current_itr) = convergence_condition;
    if convergence_condition<epsilon
        break;
    end
end

end

