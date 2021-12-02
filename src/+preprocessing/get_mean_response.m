    function mean_datafile = get_mean_response(list_datafiles)
    first_datafile = list_datafiles(1);
    ref_subject = first_datafile.subjectname;
    ref_fofu = first_datafile.fofureal;
    ref_dynamics = first_datafile.controlledelement;

    mean_datafile = first_datafile;
    [rms_e, rms_u] = preprocessing.get_rms(first_datafile);
    rmse_list = [rms_e];
    rmsu_list = [rms_u];
    if length(list_datafiles) > 1
        for datafile = list_datafiles(2:end)
            assert(strcmp(ref_subject, datafile.subjectname), "Subject doesn't match");
            assert(ref_fofu == datafile.fofureal, "Forcing fun doesn't match");
            assert(ref_dynamics == datafile.controlledelement, "Dynamics don't match");
            mean_datafile.data.Variables = mean_datafile.data.Variables + datafile.data.Variables;
            [rmse, rmsu] = preprocessing.get_rms(datafile);
            rmse_list = [rmse_list, rmse];
            rmsu_list = [rmsu_list, rmsu];
        end
    end

    mean_datafile.data.Variables = mean_datafile.data.Variables/length(list_datafiles);
    mean_datafile.rmse = rmse_list;
    mean_datafile.rmsu = rmsu_list;
end




