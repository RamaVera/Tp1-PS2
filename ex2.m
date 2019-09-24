clear all; close all; clc

noise_sigma=sqrt(0.001);
N=10000;
r=3;
M=5;

L=5; n_h=[1,2,3];
W=3.4;
h=1/2*(1+cos(2*pi/W*(n_h-(L-1)/2)));

msg=binornd(1,0.5, N,1)*2-1;

delay=[zeros(r, 1); 1];
d=filter(delay,1,msg);
u=filter(h,1,msg)+randn(N,1)*noise_sigma;

[e,y,w_eq]=LMSfunc(u,d,M,0.0075);

figure
plot(y)
hold
plot(e.^2, 'r')
legend('se�al','error')

eq_filt=conv(w_eq,h);
figure
plot(abs(fft(eq_filt,1000)), 'y')
hold
plot(abs(fft(h,1000)), 'r')
plot(abs(fft(w_eq,1000)))
legend('Global','Canal','Equalizador')

figure
stem(eq_filt)
title('Respuesta impulsiva del filtro equivalente')