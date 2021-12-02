% set(groot,'defaultFigureVisible','on')
subjects = ["Subject00", "Subject01", "Subject02", "Subject03", "Subject04", "Subject05", "Subject06", "Subject07", "Subject08", "Subject09"];
% subjects = ["Subject08"];
% conditions = ["fofu7_dyn1", "fofu6_dyn3", "fofu6_dyn3", "fofu7_dyn4"]; 
conditions = ["fofu6_dyn3", "fofu7_dyn4"];
%
start_idx = 1000;

% dyn = 3;
% fofu = 6;
for i = 1:length(conditions)
    condition = conditions(i);
    windowed_vafs = [];
    for subject = subjects
        common_name = join([subject, "_", condition], "");
        path = join(["results/tests/", subject, "/", common_name, "delay_u_lr.mat"], "");
        if isfile(path)
            load(path);
            % time slices
            T_0 = 10;
            T_f = 90;

            % 
            forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
            output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
            u_series = timeseries(exp_data.data.DYNU, exp_data.data.x_T);
            mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);

            %%
            vaf_array = tools.get_vaf_windowed(exp_data.data.DYNU, mrac_output.u.Data, 10*100);
            windowed_vafs = [windowed_vafs; vaf_array(start_idx + 1:end)];
        end
    end
    time = linspace(0, T_f, f * T_f + 1);
    figure;
    [line, shade] = tools.stdshade(windowed_vafs, 0.3, 'r', time);
    xlabel("t [s]");
    ylim([0, 1]);
    xlim([0, 80]);
    ylabel("VAF [-]");
    char_cond = char(condition);
    if condition == 'fofu6_dyn3'
        legend(line, 'Windowed VAF', 'Location', 'southeast');
    end
    tools.plot_areas(gcf, char_cond(end));
    set(gca,'FontSize', 18);
    hold on;
    % add manually outliers 
    if condition == 'fofu7_dyn4'
%         set(0,'DefaultLegendAutoUpdate','off')
        for subject = ["Subject02", "Subject07"]
            common_name = join([subject, "_", condition], "");
            path = join(["results/tests/", subject, "/outliers/", common_name, "delay_u_.mat"], "");
            if isfile(path)
            load(path);
            % time slices
            T_0 = 10;
            T_f = 90;

            % 
            forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);
            output_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
            u_series = timeseries(exp_data.data.DYNU, exp_data.data.x_T);
            mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);

            %%
            vaf_array = tools.get_vaf_windowed(exp_data.data.DYNU, mrac_output.u.Data, 10*100);
            plot_line = plot(time, vaf_array(start_idx + 1:end), 'Linewidth', 0.3);
            set(get(get(plot_line,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
            end
        end
    end    
    xlim([0, 85]);


    exportgraphics(gcf, join(["results/images/", condition, "_window_vaf_stdshade_test_lr.pdf"], ""));    
end

