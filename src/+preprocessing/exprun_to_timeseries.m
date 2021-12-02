function [forcing_func_series, output_series, u_series] = exprun_to_timeseries(exp_data)
    forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
    u_series = timeseries(exp_data.data.DYNU, exp_data.data.x_T);
    output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
end