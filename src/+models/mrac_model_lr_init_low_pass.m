function mrac_output = mrac_model_lr_init_low_pass(params)
    k_x0 = [params(1); params(2)];
    k_r0 = params(3);
    omega_c = params(4);
    delay = params(5);
    gamma_x = params(6:7);
    gamma_r = params(8);
    omega_filter = 3;
    s = tf('s');
    low_pass_filter = omega_filter/(omega_filter + s);
    sys_ol = omega_c/(s) * exp(-delay * s);
    tf_ol_pade = pade(sys_ol, 1);
    tf_cl_pade = feedback(tf_ol_pade, 1) * low_pass_filter;
    
    ref_sys = ss([tf_cl_pade; s*tf_cl_pade]);
    assignin('base', 'ref_sys', ref_sys);
    assignin('base', 'ref_x0', [0;0;0]);
    assignin('base', 'gamma_x', gamma_x);
    assignin('base', 'gamma_r', gamma_r);
    assignin('base', 'k_r0', k_r0);
    assignin('base', 'k_x0', k_x0);
    try
        out = sim('adaptive_mrac');
        mrac_output = out.y;
    catch
%         mrac_output = out.y_ref;
        fprintf("Sim not converged");
    end
end