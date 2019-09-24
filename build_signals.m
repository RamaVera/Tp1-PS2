function [d, u] = build_signals(r, N, L, W, noise_variance)
    noise_sigma=sqrt(noise_variance);
    n=[1,2,3];
    h=1/2*(1+cos(2*pi/W*(n-(L-1)/2)));
    h = [0 h 0];
    msg=binornd(1,0.5, N,1)*2-1;

    delay=[zeros(r, 1); 1];
    d=filter(delay,1,msg);
    u=filter(h,1,msg)+randn(N,1)*noise_sigma;
end

