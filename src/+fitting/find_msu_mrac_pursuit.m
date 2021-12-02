function mse = find_msu_mrac_pursuit(human_output, model, model_params_norm, lb, up)
    % computes the output of the reference model given a certain reference
    % signal and compares with the human output 
    model_params = model_params_norm .* (up' - lb');
    model_out = model(model_params);
%     tools.plot_comparison_u(human_output, model_out)
    
    stard_id = 10;
    f = 100;
    mse = sum((model_out.u.Data(stard_id*f:end) - human_output.Data(stard_id*f:end)).^2);
    lambda_ = 0.0005;
    mse
    mse_reg = lambda_ * (sum(model_out.kx.Data(:, 1).^2)  + ...
               10 * sum(model_out.kx.Data(:, 2).^2)  + ...
               sum(model_out.kr.Data.^2));
    mse_reg
    mse = mse;
end

