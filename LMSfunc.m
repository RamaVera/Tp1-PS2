function [e, y, w, w_n]=LMSfunc(u, d, M, mu)
    N=length(u);
    w=zeros(M,1);
    u=[zeros(M-1,1); u];
    y=zeros(N,1);
    e=zeros(N,1);
    w_n=zeros(M, N);
    for i=1:N
        U=u(i+M-1:-1:i);
        y(i)=U'*w;
        e(i)=d(i)-y(i);
        w_n(:, i) = w;
        w=w+mu*U*e(i);
    end
end