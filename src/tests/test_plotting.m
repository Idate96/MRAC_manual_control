path = "data/preprocessed_exp_data/test_fofu";
all_data = preprocessing.load_folder(path);

for datafile = all_data
% ft = dynx + dyne
    figure;
    plot(datafile.data.x_T, datafile.data.ft);
end


