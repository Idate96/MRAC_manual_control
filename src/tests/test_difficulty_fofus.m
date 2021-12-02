subjects = ["Subject01"];
fofu_reals = [6, 10];
dynamics = [2];
path = "data/preprocessed_exp_data";
all_data = preprocessing.load_folder(path);

mean_data_list = [];

%%
for subject = subjects
    subject_files = preprocessing.filter_name(all_data, subject);
    for dynamic = dynamics
        dynamic_files = preprocessing.filter_dynamics(subject_files, dynamics);
        for fofu_real = fofu_reals
            fofu_files = preprocessing.filter_fofureal(dynamic_files, fofu_real);
            mean_response = preprocessing.get_mean_response(fofu_files);
            mean_data_list = [mean_data_list, mean_response];
        end
    end 
end 


%% comparison between the two fofu
mean_rmse_1 = mean(mean_data_list(1).rmse);
std_rmse_1 = std(mean_data_list(1).rmse);

mean_rmse_2 = mean(mean_data_list(2).rmse);
std_rmse_2 = std(mean_data_list(2).rmse);

%% compare other datasets 
subjects = ["Subject01"];
fofu_reals = [6, 7, 8];
dynamics = [3];
mean_data_list = [];
path = "data/preprocessed_exp_data";
all_data = preprocessing.load_folder(path);


for subject = subjects
    subject_files = preprocessing.filter_name(all_data, subject);
    for dynamic = dynamics
        dynamic_files = preprocessing.filter_dynamics(subject_files, dynamics);
        for fofu_real = fofu_reals
            fofu_files = preprocessing.filter_fofureal(dynamic_files, fofu_real);
            mean_response = preprocessing.get_mean_response(fofu_files);
            mean_data_list = [mean_data_list, mean_response];
        end
    end 
end 

%%
mean_rmse_1 = mean(mean_data_list(1).rmse);
std_rmse_1 = std(mean_data_list(1).rmse);

mean_rmse_2 = mean(mean_data_list(2).rmse);
std_rmse_2 = std(mean_data_list(2).rmse);

mean_rmse_3 = mean(mean_data_list(3).rmse);
std_rmse_3 = std(mean_data_list(3).rmse);








