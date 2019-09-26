function X=getApaMatrix(u,k,M,O)

U=u((k-1)+M+(O-1):-1:1+(k-1));
for i=1:O
    for j=1:M    
    X(i,j)=U(i+j-1);
    end
end