%% settings for case 1 with exact delay 
f = 100;
T = 70;
time = linspace(0, T, T * f);


k_x = [14.84; 8.0]/100;
k_r = 14/100;
P = [1, 1];
gamma_x = [10; 30];
gamma_r = 10;
omega_c = 2.6;
delay = 0.20;
            
params = [k_x; k_r; omega_c; delay; gamma_x; gamma_r];

dynamics_case = 4;
fast_transition = 1;
transition = 1;

signal_73 = models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_pursuit(params);
% %%  steady state for case 2
% f = 100;
% T = 90;
% time = linspace(0, T, T * f);
% k_x0 = [-22; -5]/100;
% k_r0 = 20.5/100;
% P = [1, 1];
% gamma_x0 = [10; 10];
% gamma_r0 = 5;
% omega_c0 = 3;   
% delay_0 = 0.3;
% params = [k_x0; k_r0; omega_c0; delay_0; gamma_x0; gamma_r0];
% 
% dynamics_case = 2;
% fast_transition = 1;
% 
% signal_73 = models.forcing_func_mcruer(time, "6-4");
% ref_signal = timeseries(signal_73, time);
% % [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% % ref_signal = axis_data_1.r;
% models.mrac_pursuit(params);