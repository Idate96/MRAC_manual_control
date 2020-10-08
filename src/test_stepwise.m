path = tools.load_workspace(3, 3, 'opt_lr_init_const_ref.mat');
load(path);
fitting.mrac_model_run(axis_data_1.r, @models.mrac_model_const_ref, optimal_param);
%%
tools.plot_optimal_mrac(3, 3, 'opt_lr_init_const_ref.mat')
%%


path_2 = tools.load_workspace(3, 3, 'opt_lr_init.mat');
load(path_2);
fitting.mrac_model_run(axis_data_1.r, @models.mrac_model_lr_init, optimal_param);
%%
tools.plot_optimal_mrac(3, 3, 'opt_lr_init.mat')
