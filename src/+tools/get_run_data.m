function [vaf_y, vaf_u, params] = get_run_data(exp_data, model_func, optimal_param)

    forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
    output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
    u_series = timeseries(exp_data.data.DYNU, exp_data.data.x_T);

    % 
    mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);

    start_idx = 10;
    f = 100;
    vaf_y = tools.get_VAF(output_series.Data(start_idx*f:end), mrac_output.y.Data(start_idx*f:end));
    vaf_u = tools.get_VAF(u_series.Data(start_idx*f:end), mrac_output.u.Data(start_idx*f:end));
    params = optimal_param;
    params(1:2) = mrac_output.kx.Data(start_idx*f, :);
    kr_data_flatten =  mrac_output.kr.Data(:);
    params(3) = kr_data_flatten(start_idx*f, :);
end