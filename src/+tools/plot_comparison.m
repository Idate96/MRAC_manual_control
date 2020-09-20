function plot_comparison(reference, human_output, model_output, name)
%     set(0,'DefaultFigureVisible','off')
    figure;
    plot(reference.Time, reference.Data, 'LineWidth', 1.5); hold on;
    plot(human_output.Time, human_output.Data, 'LineWidth', 1.5); hold on;
    plot(model_output.Time, model_output.Data, 'LineWidth', 1.5);
    legend('r', 'y_{h}', 'y_{m}');
    
    saveas(gcf, join(['images/comparison/out_comp_', name, '.png'], ''))
end