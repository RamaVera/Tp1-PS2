%% Item 1.1
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
num_experiments = 200;

J_estimation = zeros(N, num_experiments);
for i=1 : num_experiments
    [d1, u1] = build_signals(r, N/2, L, W1, noise_variance);
    [d2, u2] = build_signals(r, N/2, L, W2, noise_variance);
    sum(abs(u1).^2)
    sum(abs(u2).^2)
    u = [u1 ; u2];
    d = [d1 ; d2];
    [e, y, w_eq, w_n] = LMSfunc(u, d, M, mu);
    J_estimation(:, i) = abs(e).^2;
end
J_estimation =  mean(J_estimation, 2);

figure();
hold on;
plot(20*log10(J_estimation));

%ylim([0 0.1]);
xlim([10 10000]);
title('Variaciones en el canal.');
xlabel('Tiempo')
ylabel('J [db]')