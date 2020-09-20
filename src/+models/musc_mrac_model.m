function mrac_output = musc_mrac_model(params)
    omega_c = params(1);
    delay = params(2);
    s = tf('s');
    freq = 8;
    damp = 0.7;
    sys_ol = freq^2/(s^2 + 2 * damp * freq * s + freq^2) * omega_c/s * exp(-delay * s);

    tf_ol_pade = pade(sys_ol, 1);
    tf_cl_pade = feedback(tf_ol_pade, 1);

    ref_sys = ss([tf_cl_pade; s*tf_cl_pade]);
    assignin('base', 'ref_sys', ref_sys);
    assignin('base', 'ref_x0', [0;0;0;0]);
    
    out = sim('adaptive_mrac');
    mrac_output = out.y;
end