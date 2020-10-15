function optimize_case_comp(pilot_id, condition_id)
    w = warning ('off','all');
    [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
    %% 
    % initial conditions for MRAC
    % lot of care needed to select the starting conditions
    assignin('base', 'case_', condition_id)
    k_x0 = [9; 3]/100;
    gamma_x0 = [1; 1];
    model_func = @models.mrac_model_e2y;
    omega_c0 = 2;
    delay_0 = 0.3;
    params_0 = [k_x0; omega_c0; delay_0; gamma_x0];

    lb = [.05, 0, 0.5, 0.2, 0.5, 0.5];
    up = [.30, 0.1, 5, 0.6, 20, 10];
    params_0n = params_0./up';
    %%
    % sim
    find_mse_func = @(model_params_norm) fitting.find_mse_mrac_comp(axis_data_1.y, model_func, model_params_norm, up);
    optimal_param = fitting.fit_mrac_model_comp(axis_data_1.r, find_mse_func, params_0n, lb./up);
    optimal_param = optimal_param .* up';
    assignin('base', 'optimal_param', optimal_param);
%     % 1.178, 0.23
%     %%
%     mrac_output = fitting.mrac_model_run(axis_data_1.r, mrac_func, optimal_param.*up');
%     tools.plot_comparison(axis_data_1.r, axis_data_1.y, mrac_output, "ref_opt_0");
    %%
    pilot_dir = join(['images/pilot_', num2str(pilot_id)]);
    condition_dir = join([pilot_dir, '/condition_', num2str(condition_id)]);
    path = join([condition_dir, '/opt_lr_init_comp.mat']);
    save(path)
end
