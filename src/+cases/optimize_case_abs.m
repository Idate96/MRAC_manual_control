function optimize_case_abs(pilot_id, condition_id)
    w = warning ('off','all');
    [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
    %% 
    % initial conditions for MRAC
    % lot of care needed to select the starting conditions
    assignin('base', 'case_', condition_id)
    k_r0 = 30/100;
    k_x0 = [-14; 1]/100;
    gamma_x0 = 20*[5; 10]/100;
    gamma_r0 = 5/10;
    model_func = @models.mrac_model_lr_init;
    omega_c0 = 3;
    delay_0 = 0.3;
    params_0 = [-k_x0(1); k_x0(2); k_r0; omega_c0; delay_0; gamma_x0; gamma_r0];
    lb = [0, 0, 0, 0, 0.2, 0, 0, 0];
    up = [0.3, 0.1, 0.4, 5, 0.8, 10, 10, 2];
    params_0n = params_0./up';
    %%
    % sim
    find_mse_func = @(model_params_norm) fitting.find_abs_mrac(axis_data_1.y, model_func, model_params_norm, up);
    optimal_param = fitting.fit_mrac_model_init(axis_data_1.r, find_mse_func, params_0n, lb);
    optimal_param(1) = -optimal_param(1);
    optimal_param = optimal_param .* up';
    assignin('base', 'optimal_param', optimal_param);
%     % 1.178, 0.23
%     %%
%     mrac_output = fitting.mrac_model_run(axis_data_1.r, mrac_func, optimal_param.*up');
%     tools.plot_comparison(axis_data_1.r, axis_data_1.y, mrac_output, "ref_opt_0");
    %%
    pilot_dir = join(['images/pilot_', num2str(pilot_id)]);
    condition_dir = join([pilot_dir, '/condition_', num2str(condition_id)]);
    path = join([condition_dir, '/opt_abs_lr_init.mat']);
    save(path)
end
