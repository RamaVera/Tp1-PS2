function [e, y, w, w_n]=NLMSfunc(u, d, M, mu)
    N=length(u);
    w=zeros(M,1);
    u=[zeros(M,1); u];
    epsilon=0.01;
    y=zeros(N,1);
    e=zeros(N,1);
    w_n=zeros(M, N);
    for i=M+1:N+M
        U=u(i:-1:i-M+1);
        y(i-M)=U'*w;
        e(i-M)=d(i-M)-y(i-M);
        w_n(:, i) = w;
        w=w+mu*U*e(i-M)/(epsilon+U'*U);
    end
end