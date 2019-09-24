function [e, y, w]=LMSfunc(u, d, M, mu)
    N=length(u);
    w=zeros(M,1);
    u=[zeros(M,1); u];
    y=zeros(N,1);
    e=zeros(N,1);
    for i=1:N
        U=u(i+M-1:-1:i);
        y(i)=U'*w;
        e(i)=d(i)-y(i);
        w=w+mu*U*e(i);
    end
end