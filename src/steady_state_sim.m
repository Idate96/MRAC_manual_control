T = 100;
f = 100;
dynamics_case = 2;
P = [1, 1];
fast_transition = 1;
transition = 1;

fofu_fun = preprocessing.load_forcing_fun(6);
time = linspace(0, T, T * f  + 1);
fofu = fofu_fun(time);

ref_signal = timeseries(fofu, time);

mrac_pursuit_params = [.15, 0.09, 0.15, 3, 0.25, 0, 0, 0];
mrac_output = models.mrac_pursuit(mrac_pursuit_params);

%% Manufacture fake case 

exp_data = struct();
exp_data.data = struct();
exp_data.data.ft = fofu;
exp_data.data.x_T = time;
exp_data.data.DYNU = mrac_output.u.Data;
exp_data.data.DYNX = mrac_output.y.Data;
exp_data.subjectname = 'SteadyState';
exp_data.controlledelement = 2;
exp_data.G = 100;
exp_data.fofureal = 6;


%% 
 k = {'k_x', 'k_r', 'P', 'gamma_x', 'gamma_r', 'omega_c', 'delay'};
% 
% k_x = [10.84; 6.0]/100;
% k_r = 10/100;
% P = [1, 1];
% gamma_x = [1; 1];
% gamma_r = 1;
% omega_c = 2.5;
% delay = 0.23;

k_x = [13.84; 8.7]/100;
k_r = 15.3/100;
P = [1, 1];
gamma_x = [1; 1];
gamma_r = 1;
omega_c = 2.5;
delay = 0.25;


lb = [0.08,   0,   0, 1, 0.1, 0, 0, 0];
up = [0.2, 0.12, 0.3, 4.3, 0.30, 10, 10, 10];
values = {k_x, k_r, P, gamma_x, gamma_r, omega_c, delay};

params = containers.Map(k, values);

name_file = join([exp_data.subjectname, '_fofu', num2str(exp_data.fofureal), '_dyn',  num2str(dynamics_case)]);
mkdir(join(['results/tests/', exp_data.subjectname]));
path = join(['results/tests/', exp_data.subjectname, '/', name_file, 'delay_u_.mat']);

optimal_params = cases.optimize_pursuit_u(exp_data, params, lb, up, path);
 %%

T = 100;
f = 100;
dynamics_case = 3;
P = [1, 1];
fast_transition = 1;
transition = 1;

fofu_fun = preprocessing.load_forcing_fun(6);
time = linspace(0, T, T * f  + 1);
fofu = fofu_fun(time);

ref_signal = timeseries(fofu, time);

mrac_pursuit_params = [.16, 0.04, 0.16, 3, 0.25, 0, 0, 0];
mrac_output = models.mrac_pursuit(mrac_pursuit_params);

%% Manufacture fake case 

exp_data = struct();
exp_data.data = struct();
exp_data.data.ft = fofu;
exp_data.data.x_T = time;
exp_data.data.DYNU = mrac_output.u.Data;
exp_data.data.DYNX = mrac_output.y.Data;
exp_data.subjectname = 'SteadyState';
exp_data.controlledelement = 3;
exp_data.G = 100;
exp_data.fofureal = 6;


%% 
 k = {'k_x', 'k_r', 'P', 'gamma_x', 'gamma_r', 'omega_c', 'delay'};
% 
% k_x = [10.84; 6.0]/100;
% k_r = 10/100;
% P = [1, 1];
% gamma_x = [1; 1];
% gamma_r = 1;
% omega_c = 2.5;
% delay = 0.23;

k_x = [15.84; 3.5]/100;
k_r = 16.3/100;
P = [1, 1];
gamma_x = [1; 1];
gamma_r = 1;
omega_c = 2.5;
delay = 0.25;


lb = [0.08,   0.032,   0, 1, 0.1, 0.01, 0.01, 0.01];
up = [0.2, 0.12, 0.3, 4.3, 0.30, 10, 1, 10];
values = {k_x, k_r, P, gamma_x, gamma_r, omega_c, delay};

params = containers.Map(k, values);

name_file = join([exp_data.subjectname, '_fofu', num2str(exp_data.fofureal), '_dyn',  num2str(dynamics_case)]);
mkdir(join(['results/tests/', exp_data.subjectname]));
path = join(['results/tests/', exp_data.subjectname, '/', name_file, 'delay_u_.mat']);

optimal_params = cases.optimize_pursuit_u(exp_data, params, lb, up, path);


