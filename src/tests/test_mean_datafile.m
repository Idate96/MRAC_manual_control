clear all;
datafile_1 = preprocessing.load_data('data/preprocessed_exp_data/TVJacomijnExpData_Test_nr001_dyn121_real1_dataset_random.dat');
datafile_2 = preprocessing.load_data('data/preprocessed_exp_data/TVJacomijnExpData_Test_nr001_dyn121_real1_dataset_random.dat');
list_datafiles = [datafile_1, datafile_2];

mean_datafile = preprocessing.get_mean_response(list_datafiles);


