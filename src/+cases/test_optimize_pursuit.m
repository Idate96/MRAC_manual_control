function test_optimize_pursuit(pilot_id, condition_id, params)
    w = warning ('off','all');
    [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
    %% 
    % initial conditions for MRAC
    % lot of care needed to select the starting conditions
    assignin('base', 'case_', condition_id)
    model_func = @models.mrac_pursuit;
    params_0 = [params('k_x'); params('k_r'); params('omega_c'); params('delay'); params('gamma_x'); params('gamma_r')];
    lb = [-0.2, -0.1, 0, 0, 0.2, 0, 0, 0];
    up = [0.0, 0.1, 0.5, 5, 0.8, 100, 100, 20];
    norm = up' - lb';
    params_0n = params_0./norm;
    lb_n = lb./norm';
    up_n = up./norm';
    
    %%
    % sim
    find_mse_func = @(model_params_norm) fitting.find_mse_mrac_pursuit(axis_data_1.y, model_func, model_params_norm, lb, up);
    optimal_param = fitting.fit_mrac_pursuit(axis_data_1.r, find_mse_func, params_0n, lb_n, up_n);
    optimal_param = optimal_param .* (up' - lb');
    assignin('base', 'optimal_param', optimal_param);

    pilot_dir = join(['data/pilot_', num2str(pilot_id)]);
    condition_dir = join([pilot_dir, '/condition_', num2str(condition_id)]);
    path = join([condition_dir, '/opt_lr_init.mat']);
    save(path)
end
