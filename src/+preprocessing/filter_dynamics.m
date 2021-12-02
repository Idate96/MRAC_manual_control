function data_struct_list = filter_dynamics(list_, dynamics)
    data_struct_list = [];
    for i = 1:length(list_)
        if (list_(i).controlledelement == dynamics)
            data_struct_list = [data_struct_list, list_(i)];
        end
    end
end 
     