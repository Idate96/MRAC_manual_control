time = linspace(0, 89.99, 90000);
signal = models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal, time);

s = tf('s');
k_c = 90;
p = 6;
H_c = k_c/(s*(s + p));

omega_c = 3;
delay = 0.3;
% delay_0 = 0.2;
L = omega_c/s * exp(-delay * s);

k_d = omega_c/k_c;
k_p = p * k_d;

%%
S = 0.1/(s + 0.1);
step(S);