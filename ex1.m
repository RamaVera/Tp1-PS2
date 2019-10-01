%% Item 1.1
close all; 
clear all; 

M = 3:10;
mu = 0.0075;
r = 5;
N = 3000;
L = 5;
W = 2.9;
noise_variance = 0.001;
num_experiments = 400;
J_iter = zeros(N, length(M));
w_iter = cell(length(M), 1);
for j=1 : length(M)
    w_eq_est = zeros(M(j), N, num_experiments);
    J_estimation = zeros(N, num_experiments);
    for i=1 : num_experiments
        [d, u] = build_signals(r, N, L, W, noise_variance); 
        [e, y, w_eq, w_n] = LMSfunc(u, d, M(j), mu);
        J_estimation(:, i) = abs(e).^2;
        w_eq_est(:, :, i) = w_n;
    end
    J_iter(:,j) =  mean(J_estimation, 2);
    w_iter(j) = mat2cell(mean(w_eq_est, 3), M(j), N);
end

figure();
hold on;
legends = strings(length(M),1);
for j=1 : length(M)
    plot(20*log10(J_iter(:, j)));
    legends(j) = sprintf('M = %u',M(j));
end
%ylim([0 0.1]);
xlim([10 3000]);
title('Estimacion curva de aprendizaje para distintos largos del filtro equalizador');
legend(legends)
xlabel('Tiempo')
ylabel('J [db]')

figure();
hold on;
w_plot = cell2mat(w_iter(6));
legends = strings(size(w_plot, 1),1);
for i=1 : size(w_plot, 1)
    plot(w_plot(i, :));
    legends(i) = sprintf('Coefficiente = %u',i);
end
legend(legends)
fig_title = sprintf('Coeficientes del filtro ecualizador para M = %u',M(6));
title(fig_title);
xlabel('Tiempo')
ylabel('w(j)')

figure();
hold on;
w_plot = cell2mat(w_iter(3));
legends = strings(size(w_plot, 1),1);
for i=1 : size(w_plot, 1)
    plot(w_plot(i, :));
    legends(i) = sprintf('Coefficiente = %u',i);
end
legend(legends)
fig_title = sprintf('Coeficientes del filtro ecualizador para M = %u',M(3));
title(fig_title);
xlabel('Tiempo')
ylabel('w(j)')

%% Item 1.2
close all; 
clear all; 

mu = [0.004 0.006 0.009 0.01 0.02 0.08 0.1 0.11];
M = 11;
r = 5;
N = 2000;
L = 5;
W = 2.9;
noise_variance = 0.001;
num_experiments = 500;
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
ylim([0 1]);
xlim([0 1000]);

%% Item 1.3
close all; 
clear all; 

mu = 0.0075;
M = 11;
r = [1 3 7 11 13];
N = 4000;
L = 5;
W = 2.9;
noise_variance = 0.001;
num_experiments = 400;
J_iter = zeros(N, length(r));
for j=1 : length(r)
    J_estimation = zeros(N, num_experiments);
    for i=1 : num_experiments
        [d, u] = build_signals(r(j), N, L, W, noise_variance); 
        [e, y, w_eq, w_n] = LMSfunc(u, d, M, mu);
        J_estimation(:, i) = abs(e).^2;
    end
    J_iter(:,j) =  mean(J_estimation, 2);
end

figure();
hold on;
legends = strings(length(r),1);
for j=1 : length(r)
    plot(20*log10(J_iter(:, j)));
    legends(j) = sprintf('r = %u',r(j));
end
%ylim([0 0.1]);
xlim([10 3000]);
title('Estimacion curva de aprendizaje para distintos valores de retraso');
legend(legends)
xlabel('Tiempo')
ylabel('J [db]')

J_inf = zeros(length(r), 1);
for i=1 : length(r)
    J_inf(i) = mean(J_iter(end-100:end, i));
end

figure();
plot(r, 20*log10(J_inf));
title('J infinito para distintos valores de retardo');
xlabel('Retardo');
ylabel('J(inf) [db]');