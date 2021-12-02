function plot_sensitivity(ref_signal, mrac_output_ys, mrac_output_us, mrac_output_kxs,mrac_output_kxs_dot, mrac_output_krs, list_lr, dyn)
    % plot outpu
    f = figure;
    subplot(2, 1, 1);
    for i = 1:size(mrac_output_ys, 2)
        plot(ref_signal.Time, mrac_output_ys(:, i), 'LineWidth', 1.5); hold on;
    end
    plot(ref_signal.Time, ref_signal.Data(:), 'LineWidth', 1.5, 'Color', 'k'); hold on;
    xlabel("t [s]");
    ylabel("Output [rad]");
    legendCell = cellstr(num2str(list_lr', 'lr=%.1f'));
    legendCell = [legendCell; {'r'}];
    leg = legend(legendCell, 'Interpreter', 'latex', 'Location', 'northoutside', 'NumColumns', 3);
%     leg.Layout.Tile = 'east';
    xlim([0, 90]);
    ylim([-0.12, 0.12]);
    tools.plot_areas(gcf, dyn, "");
    set(gca,'FontSize', 18);

%     exportgraphics(gcf, join(["results/images/sensitivity/sensitivity_ouput.pdf"], ""));

    
%     f = figure;
    subplot(2, 1, 2);
    for i = 1:size(mrac_output_ys, 2)
        plot(ref_signal.Time, mrac_output_us(:, i), 'LineWidth', 1.5); hold on;
    end
    xlabel("t [s]");
    ylabel("Control output [rad]");
    legendCell = cellstr(num2str(list_lr', 'lr=%.1f'));
%     leg = legend(legendCell, 'Interpreter', 'latex', 'Location', 'northwest', 'NumColumns', 2);
    tools.plot_areas(gcf, dyn, "");
    xlim([0, 90]);
    ylim([-0.02, 0.02]);
    set(gca,'FontSize', 16);
    set(f,'Position',[10 10 800 2*300])

    exportgraphics(gcf, join(["results/images/sensitivity/sensitivity_out.pdf"], ""));

    
    f = figure;
    subplot(3, 1, 1);
    for i = 1:size(mrac_output_ys, 2)
        plot(ref_signal.Time, -mrac_output_kxs(:, i), 'LineWidth', 1.5); hold on;
    end
    xlabel("t [s]");
    ylabel("k_{x1}", 'FontSize', 20);
%     legendCell = cellstr(num2str(list_lr', 'lr=%.1f'));
%     leg = legend(legendCell, 'Interpreter', 'latex', 'Location', 'northwest', 'NumColumns', 2);
    ylim([.10, .25]);
    tools.plot_areas(gcf, dyn, "");
    xlim([0, 90]);
    set(gca,'FontSize', 16);
%     set(f,'Position',[10 10 800 300])

%     exportgraphics(gcf, join(["results/images/sensitivity/sensitivity_kx.pdf"], ""));

    
%     f = figure;
    subplot(3, 1, 2);
    for i = 1:size(mrac_output_ys, 2)
        plot(ref_signal.Time, -mrac_output_kxs_dot(:, i), 'LineWidth', 1.5); hold on;
    end
    xlabel("t [s]");
    ylabel("k_{x2}", 'FontSize', 20);
        ylim([.0, .15]);
            leg = legend(legendCell, 'Interpreter', 'latex', 'Location', 'best', 'NumColumns', 2);


%     legendCell = cellstr(num2str(list_lr', 'lr=%.1f'));
%     leg = legend(legendCell, 'Interpreter', 'latex', 'Location', 'northwest', 'NumColumns', 2);
    tools.plot_areas(gcf, "3", "");
    xlim([0, 90]);
    set(gca,'FontSize', 16);
%     set(f,'Position',[10 10 800 300])

%     exportgraphics(gcf, join(["results/images/sensitivity/sensitivity_kxdot.pdf"], ""));

%     f = figure;
    subplot(3, 1, 3);
    for i = 1:size(mrac_output_ys, 2)
        plot(ref_signal.Time, mrac_output_krs(:, i), 'LineWidth', 1.5); hold on;
    end
    xlabel("t [s]");
        ylim([.10, .25]);

    ylabel("k_r", 'FontSize', 20);
    legendCell = cellstr(num2str(list_lr', 'lr=%.1f'));
%     leg = legend(legendCell, 'Interpreter', 'latex', 'Location', 'best', 'NumColumns', 2);
    tools.plot_areas(gcf, dyn, "");
    xlim([0, 90]);
    set(gca,'FontSize', 16);
    set(f,'Position',[10 10 800 3 * 300]);

    exportgraphics(gcf, join(["results/images/sensitivity/sensitivity_kr.pdf"], ""));
end