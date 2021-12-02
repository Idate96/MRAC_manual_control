% subjects = ["Subject00", "Subject01", "Subject02", "Subject03", "Subject04", "Subject05", "Subject06", "Subject08", "Subject09"];
subjects = ["Subject07"];
fofu_reals = [6, 7, 10, 11];
dynamics = [1, 2, 3, 4];

for subject = subjects
    path = "data/preprocessed_data/" + subject + "/" + subject + "_test";
    all_data = preprocessing.load_folder(path);
    %%
    mean_data_list = [];

    for fofu_real = fofu_reals
        for dyn = dynamics
            files = preprocessing.filter_datafiles(all_data, subject, fofu_real, dyn);
            if ~isempty(files)
                exp_data = preprocessing.get_mean_response(files);
                savepath = "data/mean_responses/" + subject + "_fofu" + num2str(fofu_real) + "_dyn" + num2str(dyn) + ".mat";
                save(savepath, 'exp_data');
            end
        end
    end
end
% 
% %%
% subject = "Subject02";
% dyn = 4;
% fofu_real = 7;
% load("data/mean_responses/" + subject + "_fofu" + num2str(fofu_real) + "_dyn" + num2str(dyn) + ".mat");
