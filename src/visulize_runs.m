clear all;
subjects = ["Subject08"];
fofu_reals = [6, 7, 10, 11];
dynamics = [1, 2, 3, 4];
path = "data/preprocessed_data/Subject08/Subject08_test";
all_data = preprocessing.load_folder(path);
%%
filtered_runs = [];

for subject = subjects
    for fofu_real = fofu_reals
        for dyn = dynamics
            files = preprocessing.filter_datafiles(all_data, subject, fofu_real, dyn);
            if ~isempty(files)
                filtered_runs = [filtered_runs, files];
            end
        end
    end 
end 


for file = filtered_runs
    tools.plot_output(file);
end