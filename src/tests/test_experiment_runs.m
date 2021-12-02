subjects = ["Subject00"];
fofu_reals = [6, 7, 8, 9];
path = "data/preprocessed_exp_data";
all_data = preprocessing.load_folder(path);
%%
mean_data_list = [];

for subject = subjects
    subject_files = preprocessing.filter_name(all_data, subject);
    for fofu_real = fofu_reals
        fofu_files = preprocessing.filter_fofureal(subject_files, fofu_real);
        mean_response = preprocessing.get_mean_response(fofu_files);
        mean_data_list = [mean_data_list, mean_response];
    end 
end 

%% plot mean reponse
for mean_data = mean_data_list
    tools.plot_output(mean_data);
end

%%
for exp_data = mean_data_list

    %% sim settings
%     T = 90;
%     f = 100;
%     [fofu_name, dynamics_str, speed_str] = preprocessing.fofuid_2_runvars(exp_data.fofureal);
%     dynamics_case = str2num(dynamics_str);
%     fast_transition = str2num(speed_str);
%     transition_num = 3;
% 
%     P = [1, 1];
    [fofu_name, dynamics_str, speed_str] = preprocessing.fofuid_2_runvars(exp_data.fofureal);
    dynamics_case = str2num(dynamics_str);
    fast_transition = str2num(speed_str);
    transition_num = 3;    
    %% optimization

    k = {'k_x', 'k_r', 'P', 'gamma_x', 'gamma_r', 'omega_c', 'delay'};

    if dynamics_case == 3
        % initial values
        k_x = [-11.84; -1.0]/100;
        k_r = 13/100;
        P = [1, 1];
        gamma_x = [5; 5];
        gamma_r = 1;
        omega_c = 3.93;
        delay = 0.30;
    elseif dynamics_case == 4
        k_x = [-11.45; -1]/100;
        k_r = 12.0/100;
        P = [1, 1];
        gamma_x = [6.37; 9.37];
        gamma_r = 1.5;
        omega_c = 2.82;
        delay = 0.22;
    end

    values = {k_x, k_r, P, gamma_x, gamma_r, omega_c, delay};

    params = containers.Map(k, values);

    name_file = join([exp_data.subjectname, '_fofu', num2str(exp_data.fofureal)]);
    path = join(['results/tests/', exp_data.subjectname, '/', name_file, '.mat']);

    optimal_params = cases.optimize_pursuit(exp_data, params, path);

end

%% plot output 
name_file = join([exp_data.subjectname, '_fofu', num2str(exp_data.fofureal)]);
path = join(['results/tests/', name_file, '.mat']);

[fofu_name, dynamics_str, speed_str] = preprocessing.fofuid_2_runvars(exp_data.fofureal);
dynamics_case = str2num(dynamics_str);
fast_transition = str2num(speed_str);
transition_num = 3;
forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
    
optimal_state = load(path);
optimal_params = optimal_state.optimal_param;
% optimal_params(3) = 0.13;
% optimal_params(8) = 2;
model_func = @models.mrac_pursuit;
mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_params);
tools.plot_comparison(forcing_func_series, output_series, mrac_output, "test");
