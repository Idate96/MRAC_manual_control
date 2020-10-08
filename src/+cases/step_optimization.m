function step_optimization(pilot_id, condition_id)
    w = warning ('off','all');
    [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
    
    %% fit reference model first 
    model_ref_func = @models.integrator_delay;
    num_cases = 20;
    mse_values = zeros(num_cases, 1);
    opt_params = zeros(num_cases, 2);

    for i = 1:num_cases
        ref_model_params_0 = [normrnd(3, 0.5), normrnd(0.3, 0.1)];
        [ref_model_params, mse] = fitting.fit_ref_model(axis_data_1.r, axis_data_1.y, model_ref_func, ref_model_params_0);
        mse_values(i) = mse;
        opt_params(i, :) = ref_model_params;
    end

    [~, id_min] = min(mse_values);
    ref_model_params = opt_params(id_min, :);
    
    omega_c = ref_model_params(1);
    delay = ref_model_params(2);
    
    s = tf('s');
    sys_ol = omega_c/(s) * exp(-delay * s);
    tf_ol_pade = pade(sys_ol, 1);
    tf_cl_pade = feedback(tf_ol_pade, 1);
    
    ref_x0 = [0; 0];
    ref_sys = ss([tf_cl_pade; s*tf_cl_pade]);
    assignin('base', 'ref_model_params', ref_model_params);
    assignin('base', 'ref_sys', ref_sys);
    assignin('base', 'ref_x0', ref_x0);
    
    %% 
    % initial conditions for MRAC
    % lot of care needed to select the starting conditions
    assignin('base', 'case_', condition_id)
    k_r0 = 15/100;
    k_x0 = [-14; 1]/100;
    gamma_x0 = 20*[5; 10]/100;
    gamma_r0 = 5/10;
    model_func = @models.mrac_model_const_ref;
    params_0 = [-k_x0(1); k_x0(2); k_r0; gamma_x0; gamma_r0];
    lb = [0, 0, 0, 0, 0, 0];
    up = [0.3, 0.1, 0.3, 10, 10, 2];
    params_0n = params_0./up';
    %%
    % sim
    optimal_param = fitting.fit_mrac_fixed_ref_model_init(axis_data_1.r, axis_data_1.y, model_func, params_0n, lb, up);
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
    path = join([condition_dir, '/opt_lr_init_const_ref.mat']);
    save(path)
end
