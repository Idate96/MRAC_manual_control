function [data_axis_1, data_axis_2] = get_mean_response_test(pilot_id, condition_id)
    load(join(['data/test_data/Data_Pil', num2str(pilot_id), '.mat']));
    data = eval(join(['data_cond', num2str(condition_id)]));
    t = data.t(:, 1);
    y_mean_1 = mean(data.y1(:, 1:end), 2);
    r_1 = data.ft1(:, 1);
    y_mean_2 = mean(data.y2(:, 1:end), 2);
    r_2 = data.ft2(:, 1);
    time_begin = 0;
    
    y_mean_1 = remove_begin_run(y_mean_1, t, time_begin);
    y_mean_2 = remove_begin_run(y_mean_2, t, time_begin);
    r_1 = remove_begin_run(r_1, t, time_begin);
    r_2 = remove_begin_run(r_2, t, time_begin);
    
    t = t(t > time_begin);
    t = t - t(1) + 0.01;
    
    y_1 = timeseries(deg2rad(y_mean_1), t);
    y_2 = timeseries(deg2rad(y_mean_2), t);
    r_1 = timeseries(deg2rad(r_1), t);
    r_2 = timeseries(deg2rad(r_2), t);
    
    data_axis_1.y = y_1;
    data_axis_2.y = y_2;
    
    data_axis_1.r = r_1;
    data_axis_2.r = r_2;  
end


function data_filtered = remove_begin_run(data, t, t_begin)
    data_filtered = data(t > t_begin);
end