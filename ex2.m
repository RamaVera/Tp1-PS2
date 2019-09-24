clear all; close all; clc

N_fft=1024; %Number of samples used in the ffts
noise_sigma=sqrt(0.001); %noise level
N=10000; %total number of samples
r=5; %sample dalay
M=11; %equalizer order
mu=0.0075; %learning rate

L=5; n_h=[1,2,3]; W=[3, 3.4, 3.8]; %channel parameters
%% end of settings
for W=W
    h=1/2*(1+cos(2*pi/W*(n_h-(L-1)/2)));
    h=[0, h, 0]; %channel generating
    
    msg=binornd(1,0.5, N,1)*2-1; %message generating
    %applying delay
    delay=[zeros(r, 1); 1]; 
    
    d=filter(delay,1,msg); 
    u=filter(h,1,msg)+randn(N,1)*noise_sigma; %passing signal through channel and adding noise

    [e,y,w_eq]=LMSfunc(u,d,M,mu); %calculating the equalizer

    %% plots en dB
    eq_filt=conv(w_eq,h); % equivalent filter
    figure
    plot(y)
    hold
    plot(e.^2, 'r')
    legend('se�al','error')
    title(['Error y se�al recuperada para W=', num2str(W)])

    frequency_vector=(0:N_fft-1)/N_fft*2*pi; %vector de frecuencias 
    
    figure
    plot(frequency_vector, 20*log10(abs(fft(eq_filt,N_fft))), 'y')
    hold
    plot(frequency_vector, 20*log10(abs(fft(h,N_fft))), 'r')
    plot(frequency_vector, 20*log10(abs(fft(w_eq,N_fft))))
    legend('Global','Canal','Equalizador')
    ylabel('|H(w)|  (dB)')
    xlabel('w (rad/s)')
    title(['Respuesta de los filtros para W=', num2str(W)])
    
    figure
    stem(eq_filt)
    title(['Respuesta impulsiva del filtro equivalente para W=', num2str(W)])
end
