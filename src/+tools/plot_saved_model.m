function plot_saved_model(exp_data)
    T = 90;
    f = 100;
    [fofu_name, dynamics_str, speed_str] = preprocessing.fofuid_2_runvars(exp_data.fofureal);
    dynamics_case = str2num(dynamics_str);
    fast_transition = str2num(speed_str);
    transition_num = 3;

    forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
    output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
    P = [1, 1];
    
    name_file = join([exp_data.subjectname, '_fofu', num2str(exp_data.fofureal)]);
    path = join(['results/tests/', name_file, '.mat']);

    optimal_state = load(path);
    optimal_params = optimal_state.optimal_param;
    % optimal_params(2) = -0.0;
    % optimal_params(3) = 0.12
    model_func = @models.mrac_pursuit;
    mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_params);
    tools.plot_comparison(forcing_func_series, output_series, mrac_output, "test");
end