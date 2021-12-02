% subjects = ["Subject00", "Subject01", "Subject03", "Subject04", "Subject05", "Subject06", "Subject08", "Subject09"];
subjects = ["Subject04", "Subject06"];
fofu_reals = [6];
dynamics = [3];

for subject = subjects
    path = "data/preprocessed_data/" + subject + "/" + subject + "_test";
    all_data = preprocessing.load_folder(path);
    %%
    mean_data_list = [];

    for fofu_real = fofu_reals
        for dyn = dynamics
            files = preprocessing.filter_datafiles(all_data, subject, fofu_real, dyn);
            if ~isempty(files)
                mean_response = preprocessing.get_mean_response(files);
                mean_data_list = [mean_data_list, mean_response];
            end
        end
    end 

    %% plot mean reponse
    % for mean_data = mean_data_list
    %     tools.plot_output(mean_data);
    % end

    %% separate steady from unsteady runs 
    mean_steady_runs = [preprocessing.filter_dynamics(mean_data_list, 1), preprocessing.filter_dynamics(mean_data_list, 2)];
    mean_unsteady_runs = [preprocessing.filter_dynamics(mean_data_list, 3), preprocessing.filter_dynamics(mean_data_list, 4)];


    %%
    for exp_data = mean_unsteady_runs


        [fofu_name, dynamics_str, speed_str] = preprocessing.fofuid_2_runvars(exp_data.fofureal);
        dynamics_case = str2num(dynamics_str);
        fast_transition = str2num(speed_str);
        transition_num = 3;    

        k = {'k_x', 'k_r', 'P', 'gamma_x', 'gamma_r', 'omega_c', 'delay'};

        if dynamics_case == 3
            % initial values
            k_x = [15; 3]/100;
            k_r = 20/100;
            P = [1, 1];
            gamma_x = [7; 7];
            gamma_r = 4;
            omega_c = 2.5;
            delay = 0.20;

        elseif dynamics_case == 4
            k_x = [15.84; 8.0]/100;
            k_r = 15/100;
            P = [1, 1];
            gamma_x = [10; 50];
            gamma_r = 10;
            omega_c = 2.5;
            delay = 0.20;
        end

        lb = [0.1,     0,  0, 1.5, 0.1, 0.1, 0.5, 0.1];
        up = [0.20, 0.15, 0.20, 3.3, 0.235, 40, 40, 40];

        values = {k_x, k_r, P, gamma_x, gamma_r, omega_c, delay};

        params = containers.Map(k, values);

        name_file = join([exp_data.subjectname, '_fofu', num2str(exp_data.fofureal), '_dyn',  num2str(dynamics_case)]);
        path = join(['results/tests/', exp_data.subjectname, '/', name_file, 'red_or_.mat']);

        optimal_params = cases.optimize_pursuit_u_reduced_or(exp_data, params, lb, up, path);
    end
end
