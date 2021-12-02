clear all;
T = 89.99;
f = 100;

k = {'k_x', 'k_r', 'P', 'gamma_x', 'gamma_r', 'omega_c', 'delay'};
k_x = [-5.84; 3.38]/100;
k_r = 10.7/100;
P = [1, 1];
gamma_x = [2; 2];
gamma_r = 4;
omega_c = 2.93;
delay = 0.34;

dynamics_case = 3;
fast_transition = 1;
transition_num = 2;
values = {k_x, k_r, P, gamma_x, gamma_r, omega_c, delay};

params = containers.Map(k, values);

pilot_id = 3;
condition_id = 3;
[axis_data_1, ~] = get_mean_response_test(pilot_id, condition_id);

% save path 
pilot_dir = join(['data/pilot_', num2str(pilot_id)]);
condition_dir = join([pilot_dir, '/condition_', num2str(condition_id)]);
path = join([condition_dir, '/opt_lr_init.mat']);

cases.optimize_pursuit(axis_data_1.r, axis_data_1.y, params, path)

%%
filename = 'opt_lr_init.mat';
tools.test.plot_optimal_mrac(pilot_id, condition_id, filename)











