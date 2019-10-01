function [e, y, w, w_n]=adapFilterfunc(filterType, u, d, M, params)

%params={mu,lambda,O}

if( strcmp(filterType,'lms') )
    mu=params(1);
    [e, y, w, w_n]=LMSfunc(u, d, M, mu);
elseif( strcmp(filterType,'nlms') )
    mu=params(1);
    [e, y, w, w_n]=NLMSfunc(u, d, M, mu);
elseif( strcmp(filterType,'rls') )
    lambda=params(2);
    [e, y, w, w_n] = RLSfunc(u, d, M, lambda);
elseif( strcmp(filterType,'apa') )
    mu=params(1);
    O=params(3);
    [e, y, w, w_n]=APAfunc(u, d, M, mu, O);
else
    disp('Filter Error. Filter Dont supported')
end    




end