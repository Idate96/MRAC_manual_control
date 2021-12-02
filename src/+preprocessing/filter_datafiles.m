function list_runs = filter_datafiles(all_data, subject, fofu_real, dynamics)
    subject_files = preprocessing.filter_name(all_data, subject);
    fofu_files = preprocessing.filter_fofureal(subject_files, fofu_real);
    dynamics_files = preprocessing.filter_dynamics(fofu_files, dynamics);
    list_runs = dynamics_files;
end