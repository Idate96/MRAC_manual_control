function plot_optimal_mrac(pilot_id, condition_id)
    %%
    pilot_dir = join(['images/pilot_', num2str(pilot_id)]);
    condition_dir = join([pilot_dir, '/condition_', num2str(condition_id)]);
    path = join([condition_dir, '/opt_lr_init.mat']);
    load(path)
    assignin('base', 'case_', condition_id);
    
    mrac_output = fitting.mrac_model_run(axis_data_1.r, mrac_func, optimal_param.*up');
    tools.plot_comparison(axis_data_1.r, axis_data_1.y, mrac_output, "ref_opt_0");
end