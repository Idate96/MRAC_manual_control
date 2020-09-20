function mrac_output = mrac_model_lr(params)
    omega_c = params(1);
    delay = params(2);
    gamma_x = params(3:4);
    gamma_r = params(5);
    s = tf('s');
    sys_ol = omega_c/(s) * exp(-delay * s);
    tf_ol_pade = pade(sys_ol, 1);
    tf_cl_pade = feedback(tf_ol_pade, 1);

    ref_sys = ss([tf_cl_pade; s*tf_cl_pade]);
    assignin('base', 'ref_sys', ref_sys);
    assignin('base', 'ref_x0', [0;0]);
    assignin('base', 'gamma_x', gamma_x);
    assignin('base', 'gamma_r', gamma_r);
    
    out = sim('adaptive_mrac');
    mrac_output = out.y;
end