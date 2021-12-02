clear;
set(groot,'defaultFigureVisible','off')
subjects = ["Subject00"];
fofus = ["6", "7", "8", "9"];
mean_vafs_u = [];   
mean_vafs_out = [];

for subject = subjects
    for fofu = fofus
        common_name = join([subject, "_fofu", fofu], "");
        load(join(["results/tests/", subject, "/", common_name, "delay_eu_weighted_.mat"], ""));
        mkdir(join(["results/images/", subject], ""));
    
        % 
        forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
        output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
        u_series = timeseries(exp_data.data.DYNU, exp_data.data.x_T);

% %         % 
%           optimal_param(7) = 3;
%          optimal_param(2) = 0.0;
%         optimal_param(1) = -0.20;
        
        mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);
        
        mean_vafs_u = [mean_vafs_u, tools.get_VAF(output_series.Data, mrac_output.y.Data)];
        mean_vafs_out = [mean_vafs_out, tools.get_VAF(u_series.Data, mrac_output.u.Data)];
        
        tools.plot_comparison(forcing_func_series, output_series, mrac_output, "test");
        tools.plot_areas(gcf, dynamics_str);
        saveas(gcf, join(["results/images/", subject, "/", common_name, "delay_out_eu_w_.png"], ""));
        
        tools.plot_comparison_u(u_series, mrac_output, "test");
        tools.plot_areas(gcf, dynamics_str)
        saveas(gcf, join(["results/images/", subject, "/", common_name, "delay_u_eu_w_.png"], ""));

        tools.plot_gains(mrac_output);
        tools.plot_areas(gcf, dynamics_str)
        saveas(gcf, join(["results/images/", subject, "/", common_name, "delay_gains_eu_w_.png"], ""));
    end
end

