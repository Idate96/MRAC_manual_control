function [params] = fit_mrac_fixed_ref_model_init(reference_signal, human_output, model_func, params_0n, lb, up)
%     model_func = @models.integrator_delay;
    % ref to function needs only the parameter input to find the mse
    assignin('base', 'ref_signal', reference_signal);
    options = optimoptions('fmincon', 'OptimalityTolerance', 8e-5);
    find_mse_func = @(model_params_norm) fitting.find_mse_mrac(human_output, model_func, model_params_norm, up);
    params = fmincon(find_mse_func, params_0n, [],[],[],[], lb, [1, 1, 1, 1, 1, 1], [], options);
end 