function mrac_output = mrac_pursuit_exact_delay(params)
    k_x0 = [params(1); params(2)];
    k_r0 = params(3);
    omega_c = params(4);
    fixed_delay = params(5);
    gamma_x = params(6:7);
    gamma_r = params(8);
    s = tf('s');
    sys_ol = omega_c/(s);
    tf_ol_pade = pade(sys_ol, 1);
    tf_cl_pade = feedback(tf_ol_pade, 1);
    
    ref_sys = ss([tf_cl_pade; s*tf_cl_pade]);
    assignin('base', 'ref_sys', ref_sys);
    assignin('base', 'fixed_delay', fixed_delay);
    assignin('base', 'ref_x0', [0]);
    assignin('base', 'gamma_x', gamma_x);
    assignin('base', 'gamma_r', gamma_r);
    assignin('base', 'k_r0', k_r0);
    assignin('base', 'k_x0', k_x0);
    out = sim('mrac_pursuit_');
    mrac_output = out.y;

end
