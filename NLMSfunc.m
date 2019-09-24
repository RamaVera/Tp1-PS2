function [e, y, w]=NLMSfunc(u, d, M, mu)
    N=length(u);
    w=zeros(M,1);
    u=[zeros(M,1); u];
    epsilon=0.01;
    y=zeros(N,1);
    e=zeros(N,1);
    for i=M+1:N+M
        U=u(i:-1:i-M+1);
        y(i-M)=U'*w;
        e(i-M)=d(i-M)-y(i-M);
        w=w+mu*U*e(i-M)/(epsilon+U'*U);
    end
end