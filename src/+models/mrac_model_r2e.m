function mrac_output = mrac_model_r2e(params)
    k_x0 = params(1:2);
    P = params(3:4);
    omega_c = params(5);
    delay = params(6);
    gamma_x = params(7:8);
    omega_filter = 3;
    s = tf('s');
    low_pass_filter = omega_filter/(omega_filter + s);
    sys_ol = omega_c/(s) * exp(-delay * s);
    tf_ol_pade = pade(sys_ol, 1);
    tf_cl_pade = 1/(1 + tf_ol_pade) * low_pass_filter;
    
    ref_sys = ss([tf_cl_pade; s*tf_cl_pade]);
    assignin('base', 'P', P);
    assignin('base', 'ref_sys', ref_sys);
    assignin('base', 'ref_x0', [0;0;0]);
    assignin('base', 'gamma_x', gamma_x);
    assignin('base', 'k_x0', k_x0);
    out = sim('adaptive_mrac_r2e');
    mrac_output = out.y;

end