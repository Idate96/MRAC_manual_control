function plot_gains(mrac_output_kx, mrac_output_kr)
    figure;
    plot(mrac_output_kr.Time, mrac_output_kr.Data(:), 'LineWidth', 1.5);
    hold on;
    plot(mrac_output_kx.Time, -mrac_output_kx.Data(:, 1), 'LineWidth', 1.5);
    hold on;
    plot(mrac_output_kx.Time, -mrac_output_kx.Data(:, 2), 'LineWidth', 1.5);
    
    legend('$k_r$', '$k_x$', '$k_{\dot{x}}$', 'Interpreter','latex');
end