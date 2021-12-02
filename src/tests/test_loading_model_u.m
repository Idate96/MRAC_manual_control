clear;
set(groot,'defaultFigureVisible','off')
subjects = ["Subject24"];
fofus = ["6", "7", "10", "11"];
dyns = ["1", "2", "3", "4"];
mean_vafs_u = [];   
mean_vafs_y = [];

for subject = subjects
    for fofu = fofus
        for dyn = dyns
            common_name = join([subject, "_fofu", fofu, "_dyn", dyn], "");
            path = join(["results/tests/", subject, "/", common_name, "delay_u_.mat"], "");
            
            if isfile(path)
                load(path);
                mkdir(join(["results/images/", subject], ""));
                
                [vaf_y, vaf_u] = tools.get_vaf_data(exp_data, model_func, optimal_param);
                mean_vafs_y = [mean_vafs_y, vaf_y];
                mean_vafs_u = [mean_vafs_u, vaf_u];
                
                % time slices
                T_0 = 10;
                T_f = 100;
                
                % 
                forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
                output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
                u_series = timeseries(exp_data.data.DYNU, exp_data.data.x_T);
                mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);
                
                % remove first 10 seconds 
                forcing_func_series = tools.remove_initial_time(forcing_func_series, T_0, T_f);
                output_series = tools.remove_initial_time(output_series, T_0, T_f);
                mrac_output_y = tools.remove_initial_time(mrac_output.y, T_0, T_f);
                mrac_output_u = tools.remove_initial_time(mrac_output.u, T_0, T_f);
                u_series = tools.remove_initial_time(u_series, T_0, T_f);
                mrac_output_kx = tools.remove_initial_time(mrac_output.kx, T_0, T_f);
                mrac_output_kr = tools.remove_initial_time(mrac_output.kr, T_0, T_f);

                
                tools.plot_comparison(forcing_func_series, output_series, mrac_output_y, "test");
                tools.plot_areas(gcf, dyn);
                saveas(gcf, join(["results/images/", subject, "/", common_name, "delay_out_u_.png"], ""));

                tools.plot_comparison_u(u_series, mrac_output_u, "test");
                tools.plot_areas(gcf, dyn)
                saveas(gcf, join(["results/images/", subject, "/", common_name, "delay_u_u_.png"], ""));

                tools.plot_gains(mrac_output_kx, mrac_output_kr);
                tools.plot_areas(gcf, dyn)
                saveas(gcf, join(["results/images/", subject, "/", common_name, "delay_gains_u_.png"], ""));
            end
        end
    end
end

