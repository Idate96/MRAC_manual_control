path = tools.load_workspace(3, 3, 'opt_lr_init_comp.mat');
load(path);
fitting.mrac_model_run(axis_data_1.r, @models.mrac_model_const_ref, optimal_param);
%%
tools.plot_optimal_mrac(3, 3, 'opt_lr_init_comp.mat')