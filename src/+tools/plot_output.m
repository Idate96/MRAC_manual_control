function plot_output(reference, model_output, name)
%     set(0,'DefaultFigureVisible','off')
    figure;
    plot(reference.Time, reference.Data(:), 'LineWidth', 1.5); hold on;
    plot(model_output.Time, model_output.Data, 'LineWidth', 1.5);
    leg = legend('$r$', '$y_m$', 'Interpreter','latex');
%     title(leg, 'Output Type' );

    saveas(gcf, join(['images/output/out_', name, '.png'], ''))
    legend('r', 'y');
end

