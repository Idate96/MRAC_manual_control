function model = integrator_delay(params)
    s = tf('s');
    crossover_freq = params(1);
    delay = params(2);
    model = feedback(crossover_freq/s * exp(-delay * s), 1);
end