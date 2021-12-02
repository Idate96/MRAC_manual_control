subjects = ["Subject00"];
fofu_reals = [6, 7];
dynamics = [1];

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


    %% process first steady state 
    for exp_data = mean_steady_runs
        dynamics_case = exp_data.controlledelement;
        fast_transition = (exp_data.G == 100);
        transition = (dynamics_case > 2);

        k = {'k_x', 'k_r', 'P', 'gamma_x', 'gamma_r', 'omega_c', 'delay'};


        if dynamics_case == 1
            % initial values
            k_x = [15; 3]/100;
            k_r = 20/100;
            P = [1, 1];
            gamma_x = [0.1; 0.1];
            gamma_r = 0.1;
            omega_c = 2.5;
            delay = 0.20;

        elseif dynamics_case == 2
            k_x = [14.84; 8.0]/100;
            k_r = 14/100;
            P = [1, 1];
            gamma_x = [0.1; 0.1];
            gamma_r = 0.1;
            omega_c = 2.5;
            delay = 0.20;
        end

        lb = [0.1,   0,   0, 1, 0.1, 0.1, 0.1, 0.1];
        up = [0.2, 0.1, 0.5, 4.3, 0.25, 10, 10, 10];
        values = {k_x, k_r, P, gamma_x, gamma_r, omega_c, delay};

        params = containers.Map(k, values);

        name_file = join([exp_data.subjectname, '_fofu', num2str(exp_data.fofureal), '_dyn',  num2str(dynamics_case)]);
        mkdir(join(['results/tests/', exp_data.subjectname]));
        path = join(['results/tests/', exp_data.subjectname, '/', name_file, 'delay_u_.mat']);

        optimal_params = cases.optimize_pursuit_u(exp_data, params, lb, up, path);
    end

    % hello = "hello"
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
           k_x = [14.84; 8.0]/100;
            k_r = 14/100;
            P = [1, 1];
            gamma_x = [7; 7];
            gamma_r = 4;
            omega_c = 2.5;
            delay = 0.20;
        end

        lb = [0.1,     0,  0, 1.5, 0.1, 0.1, 0.5, 0.1];
        up = [0.25, 0.1, 0.25, 4.3, 0.25, 15, 15, 10];

        values = {k_x, k_r, P, gamma_x, gamma_r, omega_c, delay};

        params = containers.Map(k, values);

        name_file = join([exp_data.subjectname, '_fofu', num2str(exp_data.fofureal), '_dyn',  num2str(dynamics_case)]);
        path = join(['results/tests/', exp_data.subjectname, '/', name_file, 'delay_u_.mat']);

        optimal_params = cases.optimize_pursuit_u(exp_data, params, lb, up, path);
    end
end
