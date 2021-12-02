subjects = ["Subject00"];
fofu_reals = [6, 7, 8, 9];
path = "data/preprocessed_exp_data";
all_data = preprocessing.load_folder(path);
%%
fofu_8_runs = preprocessing.filter_datafiles(all_data, subjects(1), fofu_reals(3), 4);
mean_run = preprocessing.get_mean_response(fofu_8_runs);
[ft, y_mean_series, u_mean_series] = preprocessing.exprun_to_timeseries(run);

mean_vaf = tools.get_VAF(mean_run.data.DYNX, mrac_output.y.Data);
mrac_output = tools.load_optimal_model(mean_run);
i = 0;

for run = fofu_8_runs
    [fofu_timeseries, output_timeseries, u_series] = preprocessing.exprun_to_timeseries(run);
    tools.plot_comparison(fofu_timeseries, output_timeseries, mrac_output, join("test", num2str(i)));
    tools.get_VAF(mean_run.data.DYNU, mrac_output.u.Data);
    tools.get_VAF(output_timeseries.Data, mrac_output.y.Data)
    i = i + 1;
end

%%
tools.plot_comparison(ft, y_mean_series, mrac_output, "mean_out");
tools.plot_comparison_u(u_mean_series, mrac_output, "mean_u");
mean_vaf = tools.get_VAF(mean_run.data.DYNU, mrac_output.u.Data);


