function plot_plant_dynamics(datafile)
    figure;
    plot(datafile.data.x_T, datafile_1.data.DYNWb, 'LineWidth', 1.5);
    
    figure;
    plot(datafile.data.x_T, datafile.data.DYNKc);
end
