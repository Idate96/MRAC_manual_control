subjects = ["Subject00", "Subject01", "Subject02", "Subject03", "Subject04", "Subject05", "Subject06", "Subject07", "Subject08", "Subject09"];
% subjects = ["Subject00"];
conditions = ["fofu6_dyn3", "fofu7_dyn4"]; 
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
    subplot(length(conditions), 1, idx)
    condition = conditions(idx);

    for subject = subjects
        common_name = join([subject, "_", condition], "");
        path = join(["results/tests/", subject, "/", common_name, "red_or_.mat"], "");
        if isfile(path)
            load(path);
            forcing_func_series = timeseries(exp_data.data.ft, exp_data.data.x_T);  
            mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);

            % remove first 10 seconds 
             
            forcing_func_series = tools.remove_initial_time(forcing_func_series, T_0, T_f);
            mrac_output_y = tools.remove_initial_time(mrac_output.y, T_0, T_f);
            mrac_output_u = tools.remove_initial_time(mrac_output.u, T_0, T_f);
%             u_series = tools.remove_initial_time(u_series, T_0, T_f);
            mrac_output_kx = tools.remove_initial_time(mrac_output.kx, T_0, T_f);
            mrac_output_kr = tools.remove_initial_time(mrac_output.kr, T_0, T_f);
            y = [y, mrac_output_y.Data(:)];
            kx = [kx, mrac_output_kx.Data(:, 1)];
            kx_dot = [kx_dot, mrac_output_kx.Data(:, 2)];
            kr = [kr, mrac_output_kr.Data(:)];

        end
    end
    %%
    time = linspace(0, 60, 6001);
    
    [gainline(1), gainfill(1)] = tools.stdshade(kr', 0.3, 'k', time);
    hold on;
    [gainline(2), gainfill(2)] = tools.stdshade(-kx', 0.3, 'b', time);
    hold on;
    [gainline(3), gainfill(3)] = tools.stdshade(-kx_dot', 0.3, 'r', time);
    xlabel("t [s]");
    ylabel("Gain value [-]");
%     set(gca,'FontSize', 13)
    xlim([0, 60]);
    ylim([0, .2]);

    xticks(linspace(0, 60, 7));
    set(gca,'FontSize', 10);
    char_cond = char(condition);

    if idx == 1
        title("(a) DYN 12");
    elseif idx == 2
        title("(b) DYN 21");
        legend(gainline, 'k_r', 'k_{x1}', 'k_{x2}', 'FontSize', 10,  'NumColumns', 5, 'Location', 'southeast', 'Box', 'off');
    end
    tools.plot_areas_red(gcf, char_cond(end));

%     pbaspect([3.5 1 1])
    
%     exportgraphics(gcf, join(["results/images/", condition, "_gains_stdshade.pdf"], ""));
end
set(fig_,'Position',[10 10 800 (250 * length(conditions))]);
exportgraphics(gcf, join(["results/images/", condition, "_shaded_red_gains_participants.pdf"], ""), 'ContentType','vector');
close(gcf);





