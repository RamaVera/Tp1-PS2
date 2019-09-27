function [J] = evaluate_algorithm(algorithm, algorithm_params, ...
    signals_params, num_experiments, iterate_over_index)
    params_to_iterate = params(iterate_over_index);

    amt_params_to_iterate = length(params_to_iterate);
    J = zeros(N, amt_params_to_iterate);
    
    for j=1 : amt_params_to_iterate
        J_estimation = zeros(N, num_experiments);
        for i=1 : num_experimentsfinal_params
            [d, u] = build_signals(signals_params{:});
            
            final_params = algorithm_params{:};
            final_params{iterate_over_index} = params_to_iterate{i};
            final_params = 
            [e, ~, ~] = algorithm(final_params{:});
            
            J_estimation(:, i) = abs(e).^2;
        end
        J_estimation = mean(J_estimation, 2);
        J(:,j) = J_estimation;
    end
end

