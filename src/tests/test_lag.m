s = tf('s');
omega_c = 3;
delay = 0.3;

delay_integ = omega_c/s * exp(- delay * s);
pade_delay_integ = pade(delay_integ, 1);
integ = omega_c/s;

ss_delay_integ = ss(delay_integ);
ss_pade_integ = ss(pade_delay_integ);

