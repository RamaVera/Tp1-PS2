
item='2';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%    Ejercicio 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Rapidez de Convergencia
if(strcmp(item,'1'))
close all
clear all
clc
mu = 0.1;
M = 11;
r = 5;
N = 2000;
L = 5;
W = 2.9;
noise_variance = 0.001;
num_experiments = 20;
%FiltBuff={FylterType,[mu,lambda,O]}
LMSBuff={'lms',[0.02,0,0]};
NLMSBuff={'nlms',[1,0,0]};
RLSBuff={'rls',[0,1,0]};
APABuff={'apa',[1,0,10]};
FilterBuffer={LMSBuff,NLMSBuff,RLSBuff,APABuff};

figure();
hold on;
legends = strings(length(M),1);
for j=1 : length(FilterBuffer)
    filterType=FilterBuffer{j}{1};
    params=FilterBuffer{j}{2};
    
    
    J_estimation = zeros(N, num_experiments);
    for i=1 : num_experiments
        [d, u] = build_signals(r, N, L, W, noise_variance); 
        [e, y, w_eq] = adapFilterfunc(filterType, u, d, M, params);
        J_estimation(:, i) = abs(e).^2;
    end
    J_estimation = mean(J_estimation, 2);
    plot(J_estimation);
    legends(j) = sprintf('Filtro = %s',filterType);
end
title('Estimacion curva de aprendizaje para distintos algoritmos');
legend(legends)
ylim([0 1]);
xlim([0 1000]);
print('JForAllFilters','-dpng')

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Rapidez ante cambios
if(strcmp(item,'2'))

close all; 
clear all; 

M = 11;
mu = 0.0075;
r = 5;
N = 10000;
L = 5;
W1 = 2.9;
W2 = 3.4;
noise_variance = 0.001;
num_experiments = 20;

LMSBuff={'lms',[0.02,0,0]};
NLMSBuff={'nlms',[1,0,0]};
RLSBuff={'rls',[0,1,0]};
APABuff={'apa',[1,0,10]};
FilterBuffer={LMSBuff,NLMSBuff,RLSBuff,APABuff};

for j=1 : length(FilterBuffer)
    filterType=FilterBuffer{j}{1};
    params=FilterBuffer{j}{2};
    J_estimation = zeros(N, num_experiments);
    for i=1 : num_experiments
        [d1, u1] = build_signals(r, N/2, L, W1, noise_variance);
        [d2, u2] = build_signals(r, N/2, L, W2, noise_variance);
        sum(abs(u1).^2);
        sum(abs(u2).^2);
        u = [u1 ; u2];
        d = [d1 ; d2];
        [e, y, w_eq, w_n]= adapFilterfunc(filterType, u, d, M, params);
        J_estimation(:, i) = abs(e).^2;
    end
    J_estimation2(:,j) =  mean(J_estimation, 2);
end

figure();
hold on;
plot((J_estimation2));
end