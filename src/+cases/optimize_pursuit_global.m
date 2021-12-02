function optimal_param = optimize_pursuit(exp_data, params, save_path)
    w = warning ('off','all');
    
    T = 90;
    f = 100;
    [fofu_name, dynamics_str, speed_str] = preprocessing.fofuid_2_runvars(exp_data.fofureal);
    dynamics_case = str2num(dynamics_str);
    fast_transition = str2num(speed_str);
    transition_num = 3;    
    P = [1, 1];
    
    assignin('base', 'T', T);
    assignin('base', 'f', f);
    assignin('base', 'dynamics_case', dynamics_case);
    assignin('base', 'fast_transition', fast_transition);
    assignin('base', 'transition_num', transition_num);
    assignin('base', 'P', P);
    
    r = timeseries(exp_data.data.ft, exp_data.data.x_T);
    y = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
    u = timeseries(exp_data.data.DYNU, exp_data.data.x_T);
    %% 
    % initial conditions for MRAC
    % lot of care needed to select the starting conditions
%     assignin('base', 'case_', condition_id)
    model_func = @models.mrac_pursuit;
    params_0 = [params('k_x'); params('k_r'); params('omega_c'); params('delay'); params('gamma_x'); params('gamma_r')];
    lb = [-0.2, -0.1, 0, 0.5, 0.2, 0, 0, 0];
    up = [0.0, 0.0, 0.5, 5, 0.5, 15, 15, 10];
    norm = up' - lb';
    params_0n = params_0./norm;
    lb_n = lb./norm';
    up_n = up./norm';
    
    %%
    % sim
    find_mseu_func = @(model_params_norm) fitting.find_mseu_mrac_pursuit(u, y, model_func, model_params_norm, lb, up);
    [optimal_param, mse] = fitting.fit_mrac_pursuit(r, find_mseu_func, params_0n, lb_n, up_n);
    optimal_param = optimal_param .* (up' - lb');
%     assignin('base', 'optimal_param', optimal_param);
%     assignin('base', 'exp_data', exp_data);
%     evalin('base', join(['save ', save_path]));
    save(save_path)
end
