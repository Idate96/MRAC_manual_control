function model = integrator_muscular_delay(params)
    s = tf('s');
    crossover_freq = params(1);
    delay = params(2);
    freq = params(3);
    damp = params(4);
    model = feedback(freq^2/(s^2 + 2 * damp * freq * s + freq^2) * crossover_freq/s * exp(-delay * s), 1);
end