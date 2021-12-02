function datafiles = load_folder(path)
    list_allfiles = dir(path);
    datafiles = [];
    
    for i = 1:length(list_allfiles)
        if strfind(list_allfiles(i).name, "TVMRAC") > 0
            datafiles = [datafiles, preprocessing.load_data(list_allfiles(i).folder + "/" + list_allfiles(i).name)];
        end
    end
end