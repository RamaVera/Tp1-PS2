close all
clear all
clc

%Ejercicio 4

close all; 
clear all; 

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