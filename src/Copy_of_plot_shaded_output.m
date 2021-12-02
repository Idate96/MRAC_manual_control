subjects = ["Subject00", "Subject01", "Subject02", "Subject03", "Subject04", "Subject05", "Subject06", "Subject07", "Subject08", "Subject09"];
% subjects = ["SteadyState"];
% conditions = ["fofu6_dyn2", "fofu7_dyn4"];
conditions = ["fofu7_dyn1", "fofu6_dyn2", "fofu6_dyn3", "fofu7_dyn4"]; 
% columns represent the different dynamics
mean_y = [];
std_y = [];

mean_kx = [];
std_kx = [];

mean_kx_dot = [];
std_kx_dot = [];

mean_kr = [];
std_kr = [];

T_0 = 10;
f = 100;
T_f = 100;

fig_ = figure;
for idx = 1:length(conditions)
    
    condition = conditions(idx);
    y = [];
    kx = [];
    kx_dot = [];
    kr = [];
    subplot(length(conditions), 1, idx)

    for subject = subjects
        common_name = join([subject, "_", condition], "");
        path = join(["results/tests/", subject, "/", common_name, "delay_u_lr.mat"], "");
        if isfile(path)
            load(path);
            forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T); 
            output_participant = timeseries(exp_data.data.ft, exp_data.data.DYNX);
            mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);

            % remove first 10 seconds 
             
            forcing_func_series = tools.remove_initial_time(forcing_func_series, T_0, T_f);
            mrac_output_y = tools.remove_initial_time(mrac_output.y, T_0, T_f);
            mrac_output_u = tools.remove_initial_time(mrac_output.u, T_0, T_f);
%             u_series = tools.remove_initial_time(u_series, T_0, T_f);
            mrac_output_kx = tools.remove_initial_time(mrac_output.kx, T_0, T_f);
            mrac_output_kr = tools.remove_initial_time(mrac_output.kr, T_0, T_f);
            y = [y, output_participant.Data(:)];
            kx = [kx, mrac_output_kx.Data(:, 1)];
            kx_dot = [kx_dot, mrac_output_kx.Data(:, 2)];
            kr = [kr, mrac_output_kr.Data(:)];

        end
    end
    %%
    time = linspace(0, 90, 9001);
    ref_signal = [0.017; forcing_func_series.Data(:)];
    line(1) = plot(time, ref_signal(:)); hold on;
    [line(2), output_shade] = tools.stdshade(y', 0.3, 'r', time);
    xlabel("t [s]");
    ylabel("Output [rad]");
    ylim([-0.08, 0.08]);
    char_cond = char(condition);
    if idx == 1
        title("System with DYN 1");
    elseif idx == 2
        title("System with DYN 2");
    elseif idx == 3
        title("System with DYN 121");
        tools.plot_areas(gcf, char_cond(end));
    elseif idx == 4
        title("System with DYN 212");
        legend(line, 'r', 'y_h', 'FontSize', 10, 'NumColumns', 4, 'Location', 'best');
        tools.plot_areas(gcf, char_cond(end));
    end

    xlim([0, 90]);
    set(gca,'FontSize', 10);
end
set(fig_,'Position',[10 10 700 (500 * length(conditions))]);
exportgraphics(fig_, join(["results/images/", condition, "_output_shade.pdf"], ""), 'ContentType','vector');





