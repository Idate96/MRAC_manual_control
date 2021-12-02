% subjects = ["Subject03", "Subject04", "Subject05", "Subject06", "Subject08", "Subject09"];
subjects = ["Subject00"];
conditions = ["fofu7_dyn4"]; 
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
f = 70;
T_f = 70;

for condition = conditions
    y = [];
    kx = [];
    kx_dot = [];
    kr = [];
    u_out = [];

    for subject = subjects
        common_name = join([subject, "_", condition], "");
        path = join(["results/tests/", subject, "/", common_name, "red_or_.mat"], "");
        if isfile(path)
            load(path);
            forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);  
            y_series = timeseries(exp_data.data.DYNX, exp_data.data.x_T);
            u_series = timeseries(exp_data.data.DYNU, exp_data.data.x_T);
            optimal_param(7) = 45;
            mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);

            % remove first 10 seconds 
             
            forcing_func_series = tools.remove_initial_time(forcing_func_series, T_0, T_f);
            u_series = tools.remove_initial_time(u_series, T_0, T_f);
            y_series = tools.remove_initial_time(y_series, T_0, T_f)
            mrac_output_y = tools.remove_initial_time(mrac_output.y, T_0, T_f);
            mrac_output_u = tools.remove_initial_time(mrac_output.u, T_0, T_f);
%             u_series = tools.remove_initial_time(u_series, T_0, T_f);
            mrac_output_kx = tools.remove_initial_time(mrac_output.kx, T_0, T_f);
            mrac_output_kr = tools.remove_initial_time(mrac_output.kr, T_0, T_f);
            y = [y, mrac_output_y.Data(:)];
            u_out = [u_out, mrac_output_u.Data(:)];
            kx = [kx, mrac_output_kx.Data(:, 1)];
            kx_dot = [kx_dot, mrac_output_kx.Data(:, 2)];
            kr = [kr, mrac_output_kr.Data(:)];

        end
    end
    %%
    time = linspace(0, 60, 6001);
    ref_signal = [0.017; forcing_func_series.Data];
    figure;
    line(1) = plot(time, ref_signal); hold on;
    line(2) = plot(time, [0; y_series.Data(:)]);
    [line(3), output_shade] = tools.stdshade(y', 0.3, 'r', time);
    xlabel("Time [sec]");
    ylabel("Output [rad]");
    char_cond = char(condition);
    legend(line, '$r$', '$y_h$', '$y_m$', 'Interpreter','latex', 'FontSize', 13);
    tools.plot_areas(gcf, char_cond(end));
    exportgraphics(gcf, join(["results/images/", condition, "_output_red_stdshade.pdf"], ""));
    
    
    time = linspace(0, 60, 6001);
    figure;
    u_ = [0;  u_series.Data(:)];
    line(1) = plot(time, u_); hold on;
    [line(2), output_shade] = tools.stdshade(u_out', 0.3, 'r', time);
    xlabel("Time [sec]");
    ylabel("Control Output [rad]");
    char_cond = char(condition);
    legend(line, '$u_H$', '$u_m$', 'Interpreter','latex', 'FontSize', 13);
    tools.plot_areas(gcf, char_cond(end));
    exportgraphics(gcf, join(["results/images/", condition, "_u_red_stdshade.pdf"], ""));
%     %%
%     time = linspace(0, 90, 9001);
%     figure;
%     [line_e, output_shade] = tools.stdshade(sign(ref_signal)' .* (ref_signal - y)', 0.3, 'r', time);
%     xlabel("Time [sec]");
%     ylabel("Error [rad]");
%     char_cond = char(condition);
%     legend(line_e, '$e$', 'Interpreter','latex', 'FontSize', 13);
%     tools.plot_areas(gcf, char_cond(end));
%     exportgraphics(gcf, join(["results/images/", condition, "_error_red_stdshade.pdf"], ""))
    
    figure;
    [gainline(1), gainfill(1)] = tools.stdshade(kr', 0.3, 'k', time);
    hold on;
    [gainline(2), gainfill(2)] = tools.stdshade(-kx', 0.3, 'b', time);
    hold on;
    [gainline(3), gainfill(3)] = tools.stdshade(-kx_dot', 0.3, 'r', time);
    legend(gainline, '$k_r$', '$k_x$', '$k_{\dot{x}}$', 'Interpreter','latex', 'FontSize', 13);
    xlabel("Time [sec]");
    ylabel("Gain value [-]");
    tools.plot_areas(gcf, char_cond(end));
    exportgraphics(gcf, join(["results/images/", condition, "_gains_red_stdshade.pdf"], ""));
end





