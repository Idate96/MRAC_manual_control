%%  good steady state for case 1
time = linspace(0, 89.99, 90000);
k_x0 = [9; 4]/100;
P_0 = [1, 1];
gamma_x0 = [5; 5]/10;
omega_c0 = 2.0;
delay_0 = 0.3;
params = [k_x0; omega_c0; delay_0; gamma_x0];

case_ = 3;

pilot_id = 3;
condition_id = 2;

signal_73 = models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_e2y(params);

%%  steady state for case 1
time = linspace(0, 89.99, 90000);
k_x0 = [8; 1]/100;
P_0 = [1, 1];
gamma_x0 = [5; 5]/5;
omega_c0 = 2.2;
delay_0 = 0.25;
params = [k_x0; omega_c0; delay_0; gamma_x0];

case_ = 3;

pilot_id = 3;
condition_id = 2;

signal_73 = models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_e2y(params);
%%
pilot_id = 3;
condition_id = 3;
[axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
mrac_output = fitting.mrac_comp_model_run(axis_data_1.r, model_func, params);
tools.plot_comparison(axis_data_1.r, axis_data_1.y, mrac_output, "ref_opt_0");
