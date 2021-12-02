function plot_std_shade(time_axis, mean_array, std_array)
    % I create some yu and yl here, for the example
    figure;
    yu = mean_array+2*std_array;
    yl = mean_array-2*std_array;
    fill([time_axis fliplr(time_axis)], [yu fliplr(yl)], [.9 .9 .9], 'linestyle', 'none')
    hold all;
    plot(time_axis, mean_array)

    exportgraphics(gca,'test.pdf', 'BackgroundColor','none','ContentType','vector');
end