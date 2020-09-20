w = warning('off','all');
[axis_data_1, axis_data_2] = preprocessing.get_mean_response(2, 2);
%% 
% initial conditions for MRAC
% lot of care needed to select the starting conditions
case_ = 2;
k_r0 = 15/100;
k_x0 = [-14; 1]/100;
gamma_x = 20*[5; 10]/100;
gamma_r = 5/100;
mrac_func = @models.musc_mrac_model;
%%
% sim
optimal_param = fitting.fit_mrac_model(axis_data_1.r, axis_data_1.y, mrac_func);
% 1.178, 0.23
%%
mrac_output = fitting.mrac_model_run(axis_data_1.r, mrac_func, optimal_param);
tools.plot_comparison(axis_data_1.r, axis_data_1.y, mrac_output, "ref_opt_0");