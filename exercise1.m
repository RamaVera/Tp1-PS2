%% Item 1.1
close all; 
clear all; 

M = 4:7;
mu = 0.0075;
r = 5;
N = 2000;
L = 5;
W = 2.9;
noise_variance = 0.001;
num_experiments = 50;
figure();
hold on;
legends = strings(length(M),1);
for j=1 : length(M)
    J_estimation = zeros(N, num_experiments);
    for i=1 : num_experiments
        [d, u] = build_signals(r, N, L, W, noise_variance); 
        [e, y, w_eq] = LMSfunc(u, d, M(j), mu);
        J_estimation(:, i) = abs(e).^2;
    end
    J_estimation = mean(J_estimation, 2);
    plot(J_estimation);
    legends(j) = sprintf('M = %u',M(j));
end
ylim([0 0.1]);
xlim([100 N]);
title('Estimacion curva de aprendizaje para distintos largos del filtro equalizador');
legend(legends)

%% Item 1.2
close all; 
clear all; 

mu = 0.004 : 0.0010 : 0.09;
M = 11;
r = 5;
N = 2000;
L = 5;
W = 2.9;
noise_variance = 0.001;
num_experiments = 100;
figure();
hold on;
legends = strings(length(M),1);
for j=1 : length(mu)
    J_estimation = zeros(N, num_experiments);
    for i=1 : num_experiments
        [d, u] = build_signals(r, N, L, W, noise_variance); 
        [e, y, w_eq] = LMSfunc(u, d, M, mu(j));
        J_estimation(:, i) = abs(e).^2;
    end
    J_estimation = mean(J_estimation, 2);
    plot(J_estimation);
    legends(j) = sprintf('mu = %g',mu(j));
end
title('Estimacion curva de aprendizaje para distintas constantes de aprendizaje');
legend(legends)

%% Item 1.3
close all; 
clear all; 

mu = 0.0075;
M = 11;
r = 3:1:7;
N = 2000;
L = 5;
W = 2.9;
noise_variance = 0.001;
num_experiments = 100;
figure();
hold on;
legends = strings(length(M),1);
for j=1 : length(r)
    J_estimation = zeros(N, num_experiments);
    for i=1 : num_experiments
        [d, u] = build_signals(r(j), N, L, W, noise_variance); 
        [e, y, w_eq] = LMSfunc(u, d, M, mu);
        J_estimation(:, i) = abs(e).^2;
    end
    J_estimation = mean(J_estimation, 2);
    plot(J_estimation);
    legends(j) = sprintf('r = %u',r(j));
end
title('Estimacion curva de aprendizaje para distintos valores de retardo');
legend(legends)