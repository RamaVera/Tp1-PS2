function [e, y, w]=APAfunc(u, d, M, O, mu)
%u input
%d signal to estimate
%M adaptative filter order
%O Proyection Order

    epsilon=0.01;

    N=length(u);
    w=zeros(M,1);
    u=[zeros(M,1); u];
    y=zeros(N,1);
    e=zeros(N,1);
    for k=1:N-(O-1)
        X=getApaMatrix(u,k,M,O);
        D=d((k-1)+O:-1:(k-1)+1);
        E=D-X*w;      
        Y=X*w;
        w=w+mu*X'*inv(epsilon*eye(O,O)+X*X')*E;
        
        e(k+O-1)=E(1);
        y(k+O-1)=Y(1);
    end
end