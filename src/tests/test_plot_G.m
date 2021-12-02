M_1 = 30;
M_2 = 60;
T = 90;

omega_1 = 6;
omega_2 = 0.2;

G_1 = 100;
G_2 = 0.5;

G_s = [G_1, G_2];
time = linspace(0, T, 100*T);
omega = zeros(size(time));



for G = G_s
    for i = 1:length(time)
        if time(i) < T/2
            omega(i) = omega_1 + (omega_2 - omega_1)/(1 + exp(-G * (time(i) - M_1)));
        else
            omega(i) = omega_2 + (omega_1 - omega_2)/(1 + exp(-G * (time(i) - M_2)));
        end
    end
    plot(time, omega);
    hold on;
end

tools.plot_areas(gcf, '121')

    
    
