function plot_optimal_mrac(pilot_id, condition_id, filename)
    %%
    pilot_dir = join(['data/pilot_', num2str(pilot_id)]);
    condition_dir = join([pilot_dir, '/condition_', num2str(condition_id)]);
    path = join([condition_dir, '/', filename]);
    
    load(path)
    assignin('base', 'case_', condition_id);
    model_func = @models.mrac_pursuit;
    [axis_data_1, ~] = get_mean_response_test(pilot_id, condition_id);

    mrac_output = fitting.mrac_run(axis_data_1.r, model_func, optimal_param);
    tools.test.plot_comparison(axis_data_1.r, axis_data_1.y, mrac_output, "ref_opt_0");
end