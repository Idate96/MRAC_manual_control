%% 
list_unsorted = preprocessing.load_folder('data/preprocessed_exp_data/');
list_unsorted_datafiles = [];
for el = list_unsorted
    list_unsorted_datafiles = [list_unsorted_datafiles, preprocessing.load_data(el)];
end

subject_name = 'SubjectLorenzo';
fofu_real = 7;

filtered_by_name = preprocessing.filter_name(list_unsorted_datafiles, subject_name);
filtered_by_fofu = preprocessing.filter_fofureal(list_unsorted_datafiles, fofu_real);