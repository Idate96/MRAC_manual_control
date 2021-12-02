function datafile = load_data(path)
    opts = detectImportOptions(path);
    opts.DataLines = [25, inf];
    opts.VariableNamesLine = 24;
    opts.Delimiter = [', '];


    % todo: load metadata 
    data = readtable(path);
    datafile = struct();
    datafile.data = data;
    datafile.data.x_T = datafile.data.x_T + 10;

    fid = fopen(path);
    for i = 1:20
        tline = fgetl(fid);
        if i == 3
            date_string = add_zeros_to_date(tline(15:end));
            disp(date_string);
            date = datetime(date_string, 'InputFormat', "dd-MM-yyyy   HH:mm:ss");
            datafile.date = date;
        end
        if i > 4
            tline(regexp(tline,'[# -]')) = [];
            split_string = split(tline, [":", "=", "sec"]);
            if (~isempty(split_string{1}))
                [num_field, success] = str2num(split_string{2});
                if (success)
                    datafile.(split_string{1}) = num_field;
                else
                    datafile.(split_string{1}) = split_string{2};
                end
            end
        end
    end
end
    
function date_format = add_zeros_to_date(date_string)
    % assume format d-m-yyyy or dd-m-yyyy
    date_format_list = [];
    date_split_string = split(date_string,"-");
    for i = 1:length(date_split_string)
        if strlength(date_split_string(i)) == 1
            new_date_unit = "0" + date_split_string(i);
        else
            new_date_unit = date_split_string(i);
        end
        date_format_list = [date_format_list, new_date_unit];
    end
    date_format = cellstr(join(date_format_list, "-"));
end
