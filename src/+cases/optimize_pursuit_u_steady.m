function optimal_param = optimize_pursuit_u(exp_data, params, save_path)
    w = warning ('off','all');
        
    T = 100;
    f = 100;
    dynamics_case = exp_data.controlledelement;
    fast_transition = (exp_data.G == 100);
    transition = (dynamics_case > 2);
    P = [1, 1];
    
    assignin('base', 'T', T);
    assignin('base', 'f', f);
    assignin('base', 'dynamics_case', dynamics_case);
    assignin('base', 'fast_transition', fast_transition);
    assignin('base', 'transition', transition);
    assignin('base', 'P', P);
    
        
    r = timeseries(exp_data.data.ft, exp_data.data.x_T);
    u = timeseries(exp_data.data.DYNU, exp_data.data.x_T);
    
    
    model_func = @models.mrac_pursuit;
    params_0 = [params('k_x'); params('k_r'); params('omega_c'); params('delay'); params('gamma_x'); params('gamma_r')];
    lb = [-0.2, -0.1, 0, 0.5, 0.1, 0, 0, 0];
    up = [0.0, 0.0, 0.5, 5, 0.3, 1, 1, 1];
    norm = up' - lb';
    params_0n = params_0./norm;
    lb_n = lb./norm';
    up_n = up./norm';
    
    %%
    % sim
    find_msu_func = @(model_params_norm) fitting.find_msu_mrac_pursuit(u, model_func, model_params_norm, lb, up);
    optimal_param = fitting.fit_mrac_pursuit(r, find_msu_func, params_0n, lb_n, up_n);
    optimal_param = optimal_param .* (up' - lb');
%     assignin('base', 'optimal_param', optimal_param);

    save(save_path)
end
