function time_series_new = remove_initial_time(time_series, T_0, T_f)
    time_series_new = getsampleusingtime(time_series, T_0, T_f);
    time_series_new.Time = time_series_new.Time - T_0;
end