clear all; close all; clc

N_fft=1024; %Number of samples used in the ffts
noise_sigma=sqrt(0.001); %noise level
N=3000; %total number of samples
r=5; %sample dalay
M=11; %equalizer order
mu=0.0075; %learning rate

L=5; n_h=[1,2,3]; W=[3, 3.4, 3.8]; %channel parameters
e_medio=0; %initializing error
N_ESAMPLES=20; %number of error samples
%% end of settings
for W=W
    for i=1:N_ESAMPLES
        h=1/2*(1+cos(2*pi/W*(n_h-(L-1)/2)));
        h=[0, h, 0]; %channel generating

        msg=binornd(1,0.5, N,1)*2-1; %message generating
        %applying delay
        delay=[zeros(r, 1); 1]; 

        d=filter(delay,1,msg); 
        u=filter(h,1,msg)+randn(N,1)*noise_sigma; %passing signal through channel and adding noise

        [e,y,w_eq]=LMSfunc(u,d,M,mu); %calculating the equalizer
        e_medio=e_medio+e.^2/N_ESAMPLES;
    end
    
    %% plots en dB
    eq_filt=conv(w_eq,h); % equivalent filter
    figure
    plot(y)
    hold
    plot(e, 'r')
    legend('señal','error')
    title(['Error y señal recuperada para W=', num2str(W)])
    string=num2str(W);
    string(string=='.')=',';
    print(['Resources/Ejercicio2/ErrorW=',string],'-dpng')
    
    figure
    plot(e_medio,'r')
    title(['E[e^2] para W=', num2str(W)])
    frequency_vector=(0:N_fft-1)/N_fft*2*pi; %vector de frecuencias 
    
    figure
    plot(frequency_vector/pi, 20*log10(abs(fft(eq_filt,N_fft))), 'y')
    hold
    plot(frequency_vector/pi, 20*log10(abs(fft(h,N_fft))), 'r')
    plot(frequency_vector/pi, 20*log10(abs(fft(w_eq,N_fft))))
    legend('Global','Canal','Equalizador')
    ylabel('|H(w)|  (dB)')
    xlabel('w/pi (rad/s)')
    title(['Respuesta de los filtros para W=', num2str(W)])
    string=num2str(W);
    string(string=='.')=',';
    print(['Resources/Ejercicio2/ErrorW=',string],'-dpng')
    
    figure
    stem(eq_filt)
    title(['Respuesta impulsiva del filtro equivalente para W=', num2str(W)])
    string=num2str(W);
    string(string=='.')=',';
    print(['Resources/Ejercicio2/ErrorW=',string],'-dpng')
    
    %testeo de singularidad de la matriz Ruu
    [A,R]=corrmtx(u,M);
    condicion=rcond(R);
    disp(['rcond para Ruu en W=', num2str(W), ' : ', num2str(condicion)])
end
