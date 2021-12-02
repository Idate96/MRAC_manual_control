function [params, mse] = fit_mrac_pursuit(reference_signal, cost_func, params_0n, lb, up)
%     model_func = @models.integrator_delay;
    % ref to function needs only the parameter input to find the mse
    assignin('base', 'ref_signal', reference_signal);
    options = optimoptions('fmincon', 'OptimalityTolerance', 10e-4);
%     find_mse_func = @(model_params_norm) fitting.find_mse_mrac_init(human_output, model_func, model_params_norm, up);
    [params, mse] = fmincon(cost_func, params_0n, [],[],[],[], lb, up, [], options);
end 