function data_struct_list = filter_name(list_, subject_name)
    data_struct_list = [];
    for i = 1:length(list_)
        if (list_(i).subjectname == subject_name)
            data_struct_list = [data_struct_list, list_(i)];
        end
    end
end 
        