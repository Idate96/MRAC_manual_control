function mse = find_mse_mrac_pursuit_weighted(human_output, model, model_params_norm, lb, up)
    % computes the output of the reference model given a certain reference
    % signal and compares with the human output 
    model_params = model_params_norm .* (up' - lb');
    model_out = model(model_params);
    
    M1 = 25;
    M2 = 60;
    f = 100;
    start_idx = 10;
    mse1 = sum((model_out.y.Data(start_idx*f:M1*f) - human_output.Data(start_idx*f:M1*f)).^2);
    mse2 = 2 * sum((model_out.y.Data(M1*f: M2*f) - human_output.Data(M1*f: M2*f)).^2);
    mse3 = sum((model_out.y.Data(M2*f: end) - human_output.Data(M2*f: end)).^2);

    
    mse = (mse1 + mse2 + mse3)/length(model_out.y.Data(start_idx*f:end));
    
    lambda_ = 0.0005;
    mse_reg = lambda_ * (sum(model_out.kx.Data(:, 1).^2)  + ...
               10 * sum(model_out.kx.Data(:, 2).^2)  + ...
               sum(model_out.kr.Data.^2))/length(model_out.y.Data);
    mse = mse + mse_reg;
end

