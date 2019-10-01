function [e, y, w, w_n]=APAfunc(u, d, M, mu, O)
%u input
%d signal to estimate
%M adaptative filter order
%O Proyection Order

    epsilon=1;

    N=length(u);
    w=zeros(M,1);
    u=[zeros(M,1); u];
    y=zeros(N,1);
    e=zeros(N,1);
    w_n=zeros(M, N);
    for k=1:N-(O-1)
        X=getApaMatrix(u,k,M,O);
        D=d((k-1)+O:-1:(k-1)+1);
        E=D-X*w;      
        Y=X*w;
        w_n(:, k) = w;
        w=w+mu*X'*inv(epsilon*eye(O,O)+X*X')*E;
        
        if k==1
            %Em(k,:)=E;
            aux=E;
        else
            %Em(:,end+1)=0;
            %Em(k,:)=[zeros(k-1,1);E]';
            aux(end+1)=E(1);
        end
        %e(k)=mean(E);
        y(k)=mean(Y); 
    end
        e=aux';
%         for i=1:length(Em)
%             %e(i)=sum(Em(:,i).^2)/2000;   
%         end
end