function plot_control_output(model_output, name)
%     set(0,'DefaultFigureVisible','off')
    figure;
    plot(model_output.Time, model_output.Data(:), 'LineWidth', 1.5);
    leg = legend('y_{m}');
    title(leg, 'Output Type' );

    saveas(gcf, join(['images/output/u_', name, '.png'], ''))
end