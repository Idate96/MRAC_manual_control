time = linspace(0, 89.99, 90000);
k_x0 = [0.0183; 0.1];
P_0 = [1.5; 3.5];
gamma_x0 = [1; 1]/2;
omega_c0 = 3;
delay_0 = 0.3;
params = [k_x0; P_0; omega_c0; delay_0; gamma_x0];
case_ = 2;

signal = models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_e2y(params);

%% steady staet for 7-3
time = linspace(0, 89.99, 90000);
k_x0 = [0.0183; 0.1];
P_0 = [1.5; 3.5];
gamma_x0 = [1; 1]/2;
omega_c0 = 3;
delay_0 = 0.3;
params = [k_x0; P_0; omega_c0; delay_0; gamma_x0];
case_ = 2;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];
signal_73 = models.forcing_func_mcruer(time, "7-3");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_e2y(params);
%% steady state for 8-2
time = linspace(0, 89.99, 90000);
k_x0 = [0.0183; 0.1];
P_0 = [1.5; 3.5];
gamma_x0 = [1; 1]/2;
omega_c0 = 3;
delay_0 = 0.3;
params = [k_x0; P_0; omega_c0; delay_0; gamma_x0];
case_ = 2;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];
signal_73 = models.forcing_func_mcruer(time, "8-2");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_resp
models.mrac_model_e2y(params);

%%  steady state for case 1
time = linspace(0, 89.99, 90000);
k_x0 = [22; 2]/100;
P_0 = [1, 1];
gamma_x0 = [6; 3];
omega_c0 = 3.0;
delay_0 = 0.3;
params = [k_x0; P_0'; omega_c0; delay_0; gamma_x0];

case_ = 3;

pilot_id = 3;
condition_id = 2;

signal_73 = models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_e2y(params);
%%  steady state for case 1 7-3
time = linspace(0, 89.99, 90000);
k_x0 = [27; 0]/100;
P_0 = [1.5, 3.5];
gamma_x0 = 20*[20; 10]/100;
omega_c0 = 4.5;
delay_0 = 0.2;
params = [k_x0(1); k_x0(2); P_0'; omega_c0; delay_0; gamma_x0];

case_ = 1;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];
signal_73 = models.forcing_func_mcruer(time, "7-3");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_e2y(params);
%%  steady state for case 1 8-2
time = linspace(0, 89.99, 90000);
% k_x0 = [10; -5]/100;
k_x0 = [27; 0]/100;
P_0 = [1.5, 3.5];
gamma_x0 = 5*[20; 10]/100;
omega_c0 = 4.5;
delay_0 = 0.2;
params = [k_x0(1); k_x0(2); P_0'; omega_c0; delay_0; gamma_x0];

case_ = 1;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];
signal_73 = models.forcing_func_mcruer(time, "8-2");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_e2y(params);

