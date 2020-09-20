w = warning ('off','all');
pilot_id = 3;
condition_id = 1;
[axis_data_1, axis_data_2] = preprocessing.get_mean_response(pilot_id, condition_id);
%% 
% initial conditions for MRAC
% lot of care needed to select the starting conditions
case_ = condition_id;
k_r0 = 15/100;
k_x0 = [-14; 0]/100;
gamma_x0 = 20*[5; 10]/100;
gamma_r0 = 4.5/100;
mrac_func = @models.mrac_model_lr;
omega_c0 = 3;
delay_0 = 0.3;
params_0 = [omega_c0; delay_0; gamma_x0; gamma_r0];
lb = [0, 0.2, 0, 0, 0];
up = [5, 0.8, 10, 10, 2];
params_0n = params_0./up';
%%
% sim
optimal_param = fitting.fit_mrac_model(axis_data_1.r, axis_data_1.y, mrac_func, params_0n, lb, up);
% 1.178, 0.23
%%
mrac_output = fitting.mrac_model_run(axis_data_1.r, mrac_func, optimal_param);
tools.plot_comparison(axis_data_1.r, axis_data_1.y, mrac_output, "ref_opt_0");
%%
pilot_dir = join(['images/pilot_', num2str(pilot_id)]);
condition_dir = join([pilot_dir, '/condition_', num2str(condition_id)]);
path = join([condition_dir, '/opt_lr_init.mat']);
%%
save(path)