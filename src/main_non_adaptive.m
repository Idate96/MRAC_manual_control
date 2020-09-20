w = warning ('off','all');
[axis_data_1, axis_data_2] = preprocessing.get_mean_response(1, 1);
% classical McRuer model
model_func = @models.integrator_delay;
% find optimal params for ref model
optimal_params_axis_1 = fitting.fit_ref_model(axis_data_1.r, axis_data_1.y, model_func);
optimal_params_axis_2 = fitting.fit_ref_model(axis_data_2.r, axis_data_2.y, model_func);

%%
model_output = fitting.model_run(axis_data_1.r, model_func(optimal_params_axis_1)); 
tools.plot_comparison(axis_data_1.r, axis_data_1.y, model_output, "ref_opt_0");

%% 
% initial conditions for MRAC
k_r0 = 1.95;
k_x0 = [-1.6; -1.9];
gamma_x = [5; 10];
gamma_r = 20;
%%
% sim
mrac_func = @models.mrac_model;
optimal_param = fitting.fit_mrac_model(axis_data_1.r, axis_data_1.y, mrac_func);
%%
case_ = 1;
mrac_output = fitting.mrac_model_run(axis_data_1.r, mrac_func, optimal_param);
tools.plot_comparison(axis_data_1.r, axis_data_1.y, mrac_output, "ref_opt_0");