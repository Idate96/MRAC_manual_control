%% 2 to 1 
clear all;
T = 100;
f = 100;
dynamics_case = 3;
P = [1, 1];
fast_transition = 1;
transition = 1;
dyn = "3";
subject = "SteadyState";
fofu_fun = preprocessing.load_forcing_fun(6);
time = linspace(0, T, T * f  + 1);
fofu = fofu_fun(time);
ref_signal = timeseries(fofu, time);
fofu_name = "6";
common_name = join([subject, "_fofu", fofu_name, "_dyn", dyn], "");
% list_learning_rates = [0.5, 1, 5, 10];
list_learning_rates = [0.1, 1, 5, 10, 30];
list_runs = [];
T_0 = 10;
T_f = 100;
forcing_func_series = tools.remove_initial_time(ref_signal, T_0, T_f);

mrac_output_ys = [];
mrac_output_us = [];
mrac_gains_kxs = [];
mrac_gains_kxs_dot = [];
mrac_gains_krs = [];

ref_signal = timeseries(fofu, time);


for i = 1:length(list_learning_rates)
    lr = list_learning_rates(i);
    mrac_pursuit_params = [0.17, 0.02, 0.17, 3, 0.2, lr, lr, lr];
    mrac_output = models.mrac_pursuit(mrac_pursuit_params);
    
    y = tools.remove_initial_time(mrac_output.y, T_0, T_f);
    mrac_output_ys = [mrac_output_ys, y.Data];
    
    u =  tools.remove_initial_time(mrac_output.u, T_0, T_f);
    u_data = u.Data(:);
    mrac_output_us = [mrac_output_us, u_data];
    
    kx = tools.remove_initial_time(mrac_output.kx, T_0, T_f);
    mrac_gains_kxs = [mrac_gains_kxs, kx.Data(:, 1)];
    mrac_gains_kxs_dot = [mrac_gains_kxs_dot, kx.Data(:, 2)];
    
    
    kr = tools.remove_initial_time(mrac_output.kr, T_0, T_f);
    kr_data = kr.Data(:);
    mrac_gains_krs = [mrac_gains_krs, kr_data];
end
ref_signal = tools.remove_initial_time(timeseries(fofu, time), T_0, T_f);

tools.plot_sensitivity(ref_signal, mrac_output_ys, mrac_output_us, mrac_gains_kxs, mrac_gains_kxs_dot, mrac_gains_krs, list_learning_rates, dyn)


%% 1 to 2 
clear all;
T = 100;
f = 100;
dynamics_case = 4;
P = [1, 1];
fast_transition = 1;
transition = 1;
dyn = "4";
subject = "SteadyState";
fofu_fun = preprocessing.load_forcing_fun(6);
time = linspace(0, T, T * f  + 1);
fofu = fofu_fun(time);
ref_signal = timeseries(fofu, time);
fofu_name = "6";
common_name = join([subject, "_fofu", fofu_name, "_dyn", dyn], "");
% list_learning_rates = [0.5, 1, 5, 10];
list_learning_rates = [0.1, 1, 20, 60];
list_runs = [];
T_0 = 10;
T_f = 100;
forcing_func_series = tools.remove_initial_time(ref_signal, T_0, T_f);

mrac_output_ys = [];
mrac_output_us = [];
mrac_gains_kxs = [];
mrac_gains_kxs_dot = [];
mrac_gains_krs = [];

ref_signal = timeseries(fofu, time);


for i = 1:length(list_learning_rates)
    lr = list_learning_rates(i);
    mrac_pursuit_params = [0.17, 0.08, 0.17, 2.2, 0.2, 0.35 * lr, lr, 0.35 * lr];
    mrac_output = models.mrac_pursuit(mrac_pursuit_params);
    
    y = tools.remove_initial_time(mrac_output.y, T_0, T_f);
    mrac_output_ys = [mrac_output_ys, y.Data];
    
    u =  tools.remove_initial_time(mrac_output.u, T_0, T_f);
    u_data = u.Data(:);
    mrac_output_us = [mrac_output_us, u_data];
    
    kx = tools.remove_initial_time(mrac_output.kx, T_0, T_f);
    mrac_gains_kxs = [mrac_gains_kxs, kx.Data(:, 1)];
    mrac_gains_kxs_dot = [mrac_gains_kxs_dot, kx.Data(:, 2)];
    
    
    kr = tools.remove_initial_time(mrac_output.kr, T_0, T_f);
    kr_data = kr.Data(:);
    mrac_gains_krs = [mrac_gains_krs, kr_data];
end
ref_signal = tools.remove_initial_time(timeseries(fofu, time), T_0, T_f);

tools.plot_sensitivity(ref_signal, mrac_output_ys, mrac_output_us, mrac_gains_kxs, mrac_gains_kxs_dot, mrac_gains_krs, list_learning_rates, dyn)

