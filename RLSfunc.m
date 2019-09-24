function [e, y, w] = RLSfunc(u, d, M, lambda)
    N=length(u);
    u=[zeros(M,1); u];
    epsilon = 0.01;
    P = epsilon^(-1) * eye(M);
    w=zeros(M,1);
    y=zeros(N,1);
    e=zeros(N,1);
    lambda_inv = 1/lambda;
    for i=1:N
        U=u(i+M-1:-1:i);
        update_P_num = lambda_inv * P * U * transpose(U) * P;
        update_P_den = 1 + lambda_inv * transpose(U) * P * U;
        update_P = update_P_num / update_P_den;
        P = lambda_inv * (P - update_P);
        w = w + P*U*(d(i) - transpose(U)*w);
        y(i)=transpose(U)*w;
        e(i)=d(i)-y(i);
    end
end

