function X=getApaMatrix(u,k,M,O)
% U=[u(n+M+O-1) u(n+M+O-2) ... u(n) u(n+1).... u(N) ]
% Se agarra una ventana de M+O-1 valores
U=u((k-1)+M+O-1:-1:1+(k-1));
for i=1:O
    for j=1:M    
    X(i,j)=U(i+j-1);
    end
end