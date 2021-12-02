%%  steady state for case 3, fast
f = 100;
T = 90;
time = linspace(0, T, T * f);
k_x0 = [-5; 4]/100;
k_r0 = 4.2/100;
P = [1, 1];
gamma_x0 = [10; 10];
gamma_r0 = 5;
omega_c0 = 3.0;
delay_0 = 0.3;
params = [k_x0; k_r0; omega_c0; delay_0; gamma_x0; gamma_r0];


dynamics_case = 3;
fast_transition = 1;

signal_73 = -models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_pursuit(params);


%%  steady state for case 3, slow
f = 100;
T = 90;
time = linspace(0, T, T * f);
k_x0 = [-5; 4]/100;
k_r0 = 4.2/100;
P = [1, 1];
gamma_x0 = [10; 10];
gamma_r0 = 5;
omega_c0 = 3.0;
delay_0 = 0.3;
params = [k_x0; k_r0; omega_c0; delay_0; gamma_x0; gamma_r0];


dynamics_case = 3;
fast_transition = 0;

signal_73 = -models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_pursuit(params);

%%  steady state for case 4, fast
T = 90;
f = 100;
time = linspace(0, T, T * f);
k_x0 = [-22; -5]/100;
k_r0 = 20.5/100;
P = [1, 1];
gamma_x0 = [10; 10];
gamma_r0 = 5;
omega_c0 = 3.0;
delay_0 = 0.3;
params = [k_x0; k_r0; omega_c0; delay_0; gamma_x0; gamma_r0];

dynamics_case = 4;
fast_transition = 1;


signal_73 = models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_pursuit(params);
%%  steady state for case 4, slow
T = 90;
f = 100;
time = linspace(0, T, T * f);
k_x0 = [-22; -5]/100;
k_r0 = 20.5/100;
P = [1, 1];
gamma_x0 = [10; 10];
gamma_r0 = 5;
omega_c0 = 3.0;
delay_0 = 0.3;
params = [k_x0; k_r0; omega_c0; delay_0; gamma_x0; gamma_r0];

dynamics_case = 4;
fast_transition = 0;


signal_73 = models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_pursuit(params);