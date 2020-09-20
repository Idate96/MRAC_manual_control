function mse = find_mse_mrac_init(human_output, model, model_params_norm, up)
    % computes the output of the reference model given a certain reference
    % signal and compares with the human output 
    model_params = model_params_norm .* up';
    y_model = model(model_params);
    mse = sum((y_model.Data - human_output.Data).^2)/length(y_model.Data);
end

