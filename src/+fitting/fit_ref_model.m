function [params, mse] = fit_ref_model(reference_signal, human_output, model_func, params_0)
%     model_func = @models.integrator_delay;
    % ref to function needs only the parameter input to find the mse
    find_mse_func = @(model_params) fitting.find_mse(reference_signal, human_output, model_func, model_params);
    [params, mse] = fmincon(find_mse_func, params_0, [],[],[],[], [0, 0.2], [10, 0.9]);
end 