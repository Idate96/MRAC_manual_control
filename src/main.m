w = warning ('off','all');
[axis_data_1, axis_data_2] = preprocessing.get_mean_response(2, 1);
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
% lot of care needed to select the starting conditions
case_ = 1;
k_r0 = 15;
k_x0 = [-14; 1];
gamma_x = 20*[5; 10];
gamma_r = 5;
mrac_func = @models.mrac_model;
%%
% sim
optimal_param = fitting.fit_mrac_model(axis_data_1.r, axis_data_1.y, mrac_func);
%%
mrac_output = fitting.mrac_model_run(axis_data_1.r, mrac_func, optimal_param);
tools.plot_comparison(axis_data_1.r, axis_data_1.y, mrac_output, "ref_opt_0");