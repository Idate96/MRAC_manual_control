subjects = ["Subject00", "Subject01", "Subject02", "Subject03", "Subject04", "Subject05", "Subject06", "Subject07", "Subject08", "Subject09"];
% subjects = ["SteadyState"];
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
    y = [];
    kx = [];
    kx_dot = [];
    kr = [];
    time = linspace(0, 90, 9001);
    condition = conditions(idx);
    subplot(length(conditions), 1, idx)

        
    for subject = subjects
        common_name = join([subject, "_", condition], "");
        path = join(["../results/tests/", subject, "/", common_name, "delay_u_lr.mat"], "");
        if isfile(path)
            load(path);
            forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);  
%             mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);
            output_participant = timeseries(exp_data.data.DYNU, exp_data.data.x_T);
              output_participant = tools.remove_initial_time(output_participant, T_0, T_f);


            % remove first 10 seconds 
             
            forcing_func_series = tools.remove_initial_time(forcing_func_series, T_0, T_f);
%             mrac_output_y = tools.remove_initial_time(mrac_output.y, T_0, T_f);
%             mrac_output_u = tools.remove_initial_time(mrac_output.u, T_0, T_f);
% %             u_series = tools.remove_initial_time(u_series, T_0, T_f);
%             mrac_output_kx = tools.remove_initial_time(mrac_output.kx, T_0, T_f);
%             mrac_output_kr = tools.remove_initial_time(mrac_output.kr, T_0, T_f);
%             y = [y, mrac_output_y.Data(:)];
%             kx = [kx, mrac_output_kx.Data(:, 1)];
%             kx_dot = [kx_dot, mrac_output_kx.Data(:, 2)];
%             kr = [kr, mrac_output_kr.Data(:)];
            gainline(1) = plot(output_participant, 'LineWidth', 0.3); hold on;
%             gainline(2) = plot(time, -mrac_output_kx.Data(:, 2), 'Color', 'b', 'LineWidth', 0.3); hold on;
%             gainline(3) = plot(time, mrac_output_kr.Data(:), 'Color', 'r', 'LineWidth', 0.3); hold on;
        end
    end
    %%
%     ref_signal = [0.017; forcing_func_series.Data];
%     f = figure;
%     line(1) = plot(time, ref_signal); hold on;
%     [line(2), output_shade] = tools.stdshade(y', 0.3, 'r', time);
%     xlabel("Time [sec]");
%     ylabel("Output [rad]");
%     ylim([-0.07, 0.07]);
     char_cond = char(condition);
%      line = plot(forcing_func_series, 'Color', 'k'); 

%     legend(line, 'r', 'y_h', 'FontSize', 10, 'NumColumns', 2, 'Location', 'northwest');
%     tools.plot_areas(gcf, char_cond(end));
%     xlim([0, 90]);
% 
%     xticks(linspace(0, 90, 10));
%     yticks(linspace(-0.05, 0.05, 5));
%     set(gca,'FontSize', 10);
%     set(f,'Position',[10 10 800 250])
% %     pbaspect([3.5 1 1])
% %     figure('Renderer', 'painters', 'Position', [10 10 900 600])
%     exportgraphics(gcf, join(["results/images/", condition, "_output_stdshade.pdf"], ""));
%     
%     %%
%     time = linspace(0, 90, 9001);
%     f = figure;
%     [line_e, output_shade] = tools.stdshade(sign(ref_signal)' .* (ref_signal - y)', 0.3, 'r', time);
%     xlabel("Time [sec]");
%     ylabel("Error [rad]");
%     char_cond = char(condition);
%     tools.plot_areas(gcf, char_cond(end));
%     legend(line_e, '$e$', 'Interpreter','latex', 'FontSize', 10,  'NumColumns', 2, 'Location', 'southwest');
%     xlim([0, 90]);
%     xticks(linspace(0, 90, 10));
% %     yticks(linspace(-0.05, 0.05, 5));
%     set(gca,'FontSize', 10);
%     set(f,'Position',[10 10 800 250])
% 
% %     pbaspect([3.5 1 1])
% %     set(gca,'FontSize', 13)
%     exportgraphics(gcf, join(["results/images/", condition, "_error_stdshade.pdf"], ""))
    
%     f = figure;
%     [gainline(1), gainfill(1)] = tools.stdshade(kr', 0.3, 'k', time);
%     hold on;
%     [gainline(2), gainfill(2)] = tools.stdshade(-kx', 0.3, 'b', time);
%     hold on;
%     [gainline(3), gainfill(3)] = tools.stdshade(-kx_dot', 0.3, 'r', time);    

    xlabel("t [s]");
    ylabel("Output [rad]");
    ylim([-0.01, 0.01]);
    char_cond = char(condition);
    if idx == 1
        title("System with DYN 1");
    elseif idx == 2
        title("System with DYN 2");
    elseif idx == 3
        title("System with DYN 121");
%         legend();
        tools.plot_areas(gcf, char_cond(end));
    elseif idx == 4
        title("System with DYN 212");
%       legend(line, 'r', 'FontSize', 10, 'Location', 'best', 'Box', 'off');
        tools.plot_areas(gcf, char_cond(end));
%         legend();

    end

    xlabel("t [s]");
    ylabel("u [rad]");
%     set(gca,'FontSize', 13)
    xlim([0, 90]);
%     ylim([0, .25]);
    tools.plot_areas(gcf, char_cond(end));

    xticks(linspace(0, 90, 10));
    set(gca,'FontSize', 10);
%     set(gcf,'Position',[10 10 800 250])

%     pbaspect([3.5 1 1])
    

end
set(fig_,'Position',[10 10 800 (400 * length(conditions))]);
exportgraphics(gcf, join(["../results/images/", condition, "_u_participants.pdf"], ""),  'ContentType','vector');
% close(gcf);



