clear all; close all; clc

N_fft=1024; %Number of samples used in the ffts
noise_sigma=sqrt(0.001); %noise level
N=10000; %total number of samples
r=5; %sample dalay
M=11; %equalizer order
mu=0.0075; %learning rate

L=5; n_h=[1,2,3]; W=3.8; %channel parameters
h=1/2*(1+cos(2*pi/W*(n_h-(L-1)/2))) %calculando filtro de canal h

raizes=roots(h) %encontrando las raizes


den=conv([1 -raizes(2)], [raizes(1) -1]) %encontrando filtro de fase minima
%Ejemplo
%      1
%----------------
%(z^-1 - a)(bz^-1 - 1)(...)
%
% Donde 'a' es una raiz del polinomio 1 +k1 z^-1 +k2 z^-2 ... mas chica que zero, 
% y 'b' es una mayor que zero 

y=[1 zeros(1,100)];

figure
freqz(h,den)
title('espectro del filtro equivalente ecualizado')
figure
equivalent_FIR=filter(1,den,y); %filtro fir aproximado ao IIR
plot(equivalent_FIR);
title('Filtro FIR aproximado')
figure
grpdelay(equivalent_FIR);
title('Atraso de grupo del filtro aproximado')
figure
stem(conv(equivalent_FIR,h))
title('Filtro fir equivalente total aproximado')

% El filtro final no sirve a los propositos porque tiene atraso de fase
% variable
