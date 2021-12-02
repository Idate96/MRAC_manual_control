subjects = ["SubjectLorenzo"];
fofu_reals = [6, 7];
path = "data/preprocessed_exp_data";
all_data = preprocessing.load_folder(path);

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

exp_data = mean_data_list(1);

%% sim settings
T = 90;
f = 100;
[fofu_name, dynamics_str, speed_str] = preprocessing.fofuid_2_runvars(exp_data.fofureal);
dynamics_case = str2num(dynamics_str);
fast_transition = str2num(speed_str);
transition_num = 3;

forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
P = [0.5, 1];

%% optimization

k = {'k_x', 'k_r', 'P', 'gamma_x', 'gamma_r', 'omega_c', 'delay'};

% initial values
k_x = [-5.84; 3.38]/100;
k_r = 10.7/100;
P = [1, 1];
gamma_x = [2; 2];
gamma_r = 4;
omega_c = 2.93;
delay = 0.30;

% case settings


values = {k_x, k_r, P, gamma_x, gamma_r, omega_c, delay};

params = containers.Map(k, values);

name_file = join([exp_data.subjectname, exp_data.fofureal], '_');
path = join(['results/test/', name_file, '.mat']);

optimal_params = cases.optimize_pursuit(forcing_func_series, output_series, params, path);

%% plot output 

namefile = 'lorenzo_test_.mat';
load_path = join(['results/tests/', namefile]);

model_func = @models.mrac_pursuit;
optimal_state = load(load_path);
optimal_params = optimal_state.optimal_param;
% gain are hand modified 
optimal_params(6:end) = optimal_params(6:end)/5;
optimal_params(2) = -0.01;
optimal_params(1) = -0.1;
optimal_params(3) = 0.09;
optimal_params(6:end) = optimal_params(6:end)/10;
mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_params);

tools.plot_comparison(forcing_func_series, output_series, mrac_output, "test");


%% plot output with intrinsic delay

namefile = 'lorenzo_test_.mat';
load_path = join(['results/tests/', namefile]);

model_func = @models.mrac_pursuit;
optimal_state = load(load_path);
optimal_params = optimal_state.optimal_param;
% gain are hand modified 
optimal_params(6:end) = optimal_params(6:end)/5;
optimal_params(2) = 0.00;
optimal_params(1) = -0.05;
optimal_params(3) = 0.05;
% delay = 0.4
% explicitly setting the delay seems to have the opposite effect
% actually... after the change at 30 seconds the model seems have no delay
% wrt the reference signal 
optimal_params(6:end) = optimal_params(6:end);
mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_params);

tools.plot_comparison(forcing_func_series, output_series, mrac_output, "test");







