idx = 1:13;
time = linspace(0, 90, 100*90);

for id = idx
    func = preprocessing.load_forcing_fun(id);
    timeseries = func(time);
end

s = tf('s');
omega_c = 1;
delay_ = 0.1;
H_in = omega_c/s * exp(-delay_ * s);
H_c = feedback(H_in, 1);