function mrac_output = mrac_model_lr_init_low_pass_comp(params)
    k_x0 = [params(1); params(2)];
    P = params(3:4);
    omega_c = params(5);
    delay = params(6);
    gamma_x = params(7:8);
    omega_filter = 5;
    omega_filter_2 = 5;

    s = tf('s');
    low_pass_filter_1 = omega_filter/(omega_filter + s);
    low_pass_filter_2 = omega_filter_2/(omega_filter_2 + s);
    sys_ol = omega_c/(s) * exp(-delay * s);
    tf_ol_pade = pade(sys_ol, 1);
    tf_cl_pade = feedback(tf_ol_pade, 1) * low_pass_filter_1 * low_pass_filter_2;
    
    ref_sys = ss([tf_cl_pade; s*tf_cl_pade]);
    assignin('base', 'P', P);
    assignin('base', 'omega_c_ref', omega_c);
    assignin('base', 'delay_ref', delay);
    assignin('base', 'ref_sys', ref_sys);
    assignin('base', 'ref_x0', [0;0;0;0]);
    assignin('base', 'gamma_x', gamma_x);
    assignin('base', 'k_x0', k_x0);
    out = sim('adaptive_mrac_comp_original');
    mrac_output = out.y;
%         mrac_output = out.y_ref;
end