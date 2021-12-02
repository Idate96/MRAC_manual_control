function mrac_output = load_optimal_model(path)
    T = 90;
    assignin('base', 'T', T);
    f = 100;
    load(path);

    [fofu_name, dynamics_str, speed_str] = preprocessing.fofuid_2_runvars(exp_data.fofureal);
    dynamics_case = str2num(dynamics_str);
    fast_transition = str2num(speed_str);
    transition_num = 3;
    assignin('base', 'dynamics_case', dynamics_case);
    assignin('base', 'fast_transition', fast_transition);
    assignin('base', 'transition_num', transition_num);


    forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
    output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
    P = [1, 1];
    assignin('base', 'P', P);

    
%     %% plot output 
%     name_file = join([exp_data.subjectname, '_fofu', num2str(exp_data.fofureal)]);
%     path = join(['results/tests/', name_file, '_lambda_001.mat']);

    
    model_func = @models.mrac_pursuit;
    mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);
end
