function mse = find_msu_mrac_pursuit_weigthed(human_output, model, model_params_norm, lb, up)
    % computes the output of the reference model given a certain reference
    % signal and compares with the human output 
    model_params = model_params_norm .* (up' - lb');
    model_out = model(model_params);
%     tools.plot_comparison_u(human_output, model_out)
    M1 = 25;
    M2 = 60;
    f = 100;
    start_idx = 10;
    mse1 = sum((model_out.u.Data(start_idx*f:M1*f) - human_output.Data(start_idx*f:M1*f)).^2);
    mse2 = 2 * sum((model_out.u.Data(M1*f: M2*f) - human_output.Data(M1*f: M2*f)).^2);
    mse3 = sum((model_out.u.Data(M2*f: end) - human_output.Data(M2*f: end)).^2);

    mse = mse1 + mse2 + mse3;
    lambda_ = 0.0005;
    mse
    mse_reg = lambda_ * (sum(model_out.kx.Data(:, 1).^2)  + ...
               10 * sum(model_out.kx.Data(:, 2).^2)  + ...
               sum(model_out.kr.Data.^2));
    mse_reg
    mse = mse;
end

