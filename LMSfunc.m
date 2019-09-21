function [e, y, w]=LMSfunc(u, d, M, mu)

N=length(u);
w=zeros(M,1);

u=[zeros(M,1); u];

for i=1:N
    U=u(i+M:-1:i+1);
    y(i)=U'*w;
    e(i)=d(i)-y(i);
    w=w+mu*U*e(i);
end

end