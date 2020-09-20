function plot_outputs(out, name)
    set(0,'DefaultFigureVisible','off')
    figure;
    plot(out.y, 'LineWidth', 1.5); hold on;
    plot(out.y_m, 'LineWidth', 1.5); hold on;
    plot(out.y_ref, 'LineWidth', 1.5);
    legend('y', 'y_m', 'y_{ref}');
    
    saveas(gcf, join(['images/output_', name, '.png']))
    
    figure;
    plot(out.kr, 'LineWidth', 1.5); hold on; 
    plot(out.kx, 'LineWidth', 1.5); 
    legend('kr', 'kx_1', 'kx_2');
    saveas(gcf, join(['images/gain_', name, '.png']));
end