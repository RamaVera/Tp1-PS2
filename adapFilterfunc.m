function [e, y, w]=adapFilterfunc(filterType,u, d, M,params)

%params={mu,lambda,O}

if( strcmp(filterType,'lms') )
    mu=params{1};
    [e, y, w]=LMSfunc(u, d, M, mu);
elseif( strcmp(filterType,'nlms') )
    mu=params{1};
    [e, y, w]=NLMSfunc(u, d, M, mu);
elseif( strcmp(filterType,'rls') )
    lambda=params{2};
    [e, y, w] = RLSfunc(u, d, M, lambda);
elseif( strcmp(filterType,'apa') )
    mu=params{1};
    O=params{3};
    [e, y, w]=APAfunc(u, d, M, mu,O);
else
    disp('Filter Error. Filter Dont supported')
end    




end