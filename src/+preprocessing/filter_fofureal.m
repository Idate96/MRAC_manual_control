function data_struct_list = filter_fofureal(list_, fofu_real)
    data_struct_list = [];
    for i = 1:length(list_)
        if (list_(i).fofureal == fofu_real)
            data_struct_list = [data_struct_list, list_(i)];
        end
    end
end 
        