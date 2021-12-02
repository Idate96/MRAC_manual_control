function mse = find_mse_mrac_pursuit(human_output, model, model_params_norm, lb, up)
    % computes the output of the reference model given a certain reference
    % signal and compares with the human output 
    model_params = model_params_norm .* (up' - lb');
    model_out = model(model_params);
    start_idx = 10;
    f = 100;
    mse = sum((model_out.y.Data(start_idx*f:end) - human_output.Data(start_idx*f:end)).^2)/length(model_out.y.Data(start_idx * f:end));
    lambda_ = 0.0005;
    mse_reg = lambda_ * (sum(model_out.kx.Data(:, 1).^2)  + ...
               10 * sum(model_out.kx.Data(:, 2).^2)  + ...
               sum(model_out.kr.Data.^2))/length(model_out.y.Data);
    mse = mse + mse_reg;
end

