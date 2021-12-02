set(groot,'defaultFigureVisible','on')

subject = "Subject01";
dyn = 4;
fofu = 7;

% dyn = 3;
% fofu = 6;

common_name = join([subject, "_fofu", fofu, "_dyn", dyn], "");
path = join(["results/tests/", subject, "/", common_name, "delay_u_.mat"], "");
load(path);
% time slices
T_0 = 10;
T_f = 100;

% 
forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
u_series = timeseries(exp_data.data.DYNU, exp_data.data.x_T);
mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);

%%
figure;
[c, lags] = xcorr(exp_data.data.DYNU, mrac_output.u.Data, 100, 'normalized');

stem(lags, c);

%%
figure;
vaf_array = tools.get_vaf_windowed(exp_data.data.DYNU, mrac_output.u.Data, 20*100);
plot(exp_data.data.x_T, vaf_array);