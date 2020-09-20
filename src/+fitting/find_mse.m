function mse = find_mse(ref_signal, human_output, model, model_params)
    % computes the output of the reference model given a certain reference
    % signal and compares with the human output 
    model_parametrized = model(model_params);
    [y_model, t] = lsim(model_parametrized, ref_signal.Data, ref_signal.Time);
    mse = sum((y_model - human_output.Data).^2)/length(y_model);
end

