subjects = ["Subject24", "Subject25"];
fofu_reals = [9];
path = "data/preprocessed_exp_data/test_G/G_comp/";
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

% T = 90;
% f = 100;
% [fofu_name, dynamics_str, speed_str] = preprocessing.fofuid_2_runvars(exp_data.fofureal);
% dynamics_case = str2num(dynamics_str);
% fast_transition = str2num(speed_str);
% transition_num = 3;
% 
% forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
% output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
% P = [1, 1];