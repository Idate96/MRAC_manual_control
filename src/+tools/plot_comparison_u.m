function plot_comparison_u(human_output, model_output, name)
%     set(0,'DefaultFigureVisible','off')
    figure;
    plot(human_output.Time, human_output.Data(:), 'LineWidth', 1.5); hold on;
    plot(model_output.Time, model_output.Data(:), 'LineWidth', 1.5);
    leg = legend('y_{h}', 'y_{m}');
    title(leg, 'Output Type' );
end