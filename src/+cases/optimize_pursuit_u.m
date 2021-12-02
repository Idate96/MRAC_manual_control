function optimal_param = optimize_pursuit_u(exp_data, params, lb, up, save_path)
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
    norm = up' - lb';
    lb_n = lb./norm';
    up_n = up./norm';
    params_0n = params_0./norm;
    optimal_params_list = [];
    msu_list = [];
    
    find_msu_func = @(model_params_norm) fitting.find_msu_mrac_pursuit(u, model_func, model_params_norm, lb, up);

    
    %%
    % sim
    for i = 1:5
        noise = normrnd(0, 0.05, 8, 1);
        params_n = params_0n + noise;
        [optimal_param_n, msu_c] = fitting.fit_mrac_pursuit(r, find_msu_func, params_n, lb_n, up_n);
        
        optimal_param = optimal_param_n .* (up' - lb');
        optimal_params_list = [optimal_params_list, optimal_param];
        msu_list = [msu_list, msu_c];
    end
    
    [min_msu, id_msu] = min(msu_list);
    optimal_param = optimal_params_list(:, id_msu);
%     assignin('base', 'optimal_param', optimal_param);
    [vaf_y, vaf_u, params] = tools.get_run_data(exp_data, model_func, optimal_param);
    save(save_path)
end
