function mse = find_abs_mrac(human_output, model, model_params_norm, up)
    % computes the output of the reference model given a certain reference
    % signal and compares with the human output 
    model_params = model_params_norm .* up';
    y_model = model(model_params);
    mse = sum(abs(y_model.Data - human_output.Data))/length(y_model.Data);
end

