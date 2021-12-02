subjects = ["Subject00", "Subject01", "Subject02", "Subject03", "Subject04", "Subject05", "Subject06", "Subject07", "Subject08", "Subject09"];
% subjects = ["SteadyState"];
conditions = ["fofu6_dyn3", "fofu7_dyn4"]; 
% columns represent the different dynamics
em = [];

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
            mrac_output = fitting.mrac_run(forcing_func_series, model_func, optimal_param);

            % remove first 10 seconds 
             
            forcing_func_series = tools.remove_initial_time(forcing_func_series, T_0, T_f);
            mrac_output_y = tools.remove_initial_time(mrac_output.y, T_0, T_f);
            mrac_output_ym = tools.remove_initial_time(mrac_output.ym, T_0, T_f);
%             u_series = tools.remove_initial_time(u_series, T_0, T_f);
            mrac_output_kx = tools.remove_initial_time(mrac_output.kx, T_0, T_f);
            mrac_output_kr = tools.remove_initial_time(mrac_output.kr, T_0, T_f);
            em = [em, mrac_output_y.Data(:) - mrac_output_ym.Data(:)];
        end
    end
  
    %%
    time = linspace(0, 90, 9001);
%     f = figure;
    [line_e, output_shade] = tools.stdshade(em', 0.3, 'r', time);
    xlabel("t [s]");
    ylabel("Error [rad]");
     ylim([-0.025, 0.025]);

    char_cond = char(condition);
    if condition == "fofu7_dyn4"
        title("(b) DYN 212")
        legend(line_e, '$e_p$', 'Interpreter','latex', 'FontSize', 10,  'NumColumns', 3, 'Location', 'southwest');
    else
        title("(a) DYN 121");
    end
    tools.plot_areas(gcf, char_cond(end));
    xlim([0, 90]);
    xticks(linspace(0, 90, 10));
    set(gca,'FontSize', 10);
   
end
set(fig_,'Position',[10 10 700 2 * 250])
exportgraphics(fig_, join(["results/images/", condition, "_error_model_stdshade.pdf"], ""),  'ContentType','vector')
    




