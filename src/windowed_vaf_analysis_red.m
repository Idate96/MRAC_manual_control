% set(groot,'defaultFigureVisible','on')
subjects = ["Subject00", "Subject01", "Subject03", "Subject04", "Subject05", "Subject06", "Subject08", "Subject09"];
% subjects = ["Subject01"];
conditions = [ "fofu7_dyn4", "fofu6_dyn3"]; 
% conditions = [ "fofu6_dyn3"];
%
P = [1; 1];
start_idx = 1000;
f = 100;
T = 70;
% dyn = 3;
% fofu = 6;
for condition = conditions
    windowed_vafs = [];
    for subject = subjects
        common_name = join([subject, "_", condition], "");
        path = join(["results/tests/", subject, "/", common_name, "red_or_.mat"], "");
        load(path);
        % time slices
        T = 70;
        T_0 = 10;
        T_f = 70;
        % 
        forcing_func_series = timeseries(exp_data.data.ft(1:T_f * f), exp_data.data.x_T(1:T_f * f));
        output_series = timeseries(exp_data.data.DYNX(1:T_f * f), exp_data.data.x_T(1:T_f * f));
        u_series = timeseries(exp_data.data.DYNU(1:T_f * f), exp_data.data.x_T(1:T_f * f));
%         optimal_param(8) = 10;
%           optimal_param(7) = 10;
%           optimal_param(4) = 2.6;
%           optimal_param(5) = 0.3;
%         optimal_param(6) = 10;
        mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);
        
        %%
        vaf_array = tools.get_vaf_windowed(exp_data.data.DYNU(1:T_f * f), mrac_output.u.Data(1:T_f * f), 10*100);
        windowed_vafs = [windowed_vafs; vaf_array(start_idx:end)];
    end
    time = linspace(0, (T_f - T_0), f * (T_f-T_0) + 1);
    figure;
    [line, shade] = tools.stdshade(windowed_vafs, 0.3, 'r', time);
    xlabel("t [s]");
    ylim([0, 1]);
    xlim([0, 55]);
    xticks(linspace(0, 60, 7));
    ylabel("VAF [-]");
    char_cond = char(condition);
    if condition == "fofu6_dyn3"
        legend(line, 'Windowed VAF', 'Location', 'southwest');
    end

    tools.plot_areas(gcf, char_cond(end));
        set(gca,'FontSize', 18);

    exportgraphics(gcf, join(["results/images/", condition, "_window_vaf_red.pdf"], ""));    
end

