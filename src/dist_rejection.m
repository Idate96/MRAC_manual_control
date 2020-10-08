s = tf('s');
omega = 3;
delay = 0.3;
L = omega/s * exp(-delay * s);
tf_ol_pade = pade(L, 1);
G = feedback(L, 1);
S = 1/(1 + tf_ol_pade);
lsim(S, ref_signal.Data(:)', ref_signal.Time/0.2);


