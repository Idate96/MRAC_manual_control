function mrac_output = mrac_model_e2y(params)
    k_x0 = params(1:2);
%     P = params(3:4);
    P = [1.5 1; 1.5, 1];
    omega_c = params(3);
    delay = params(4);
    gamma_x = params(5:6);
    s = tf('s');
    sys_ol = omega_c/(s);
    tf_cl_pade = sys_ol;
    
    ref_sys = ss([tf_cl_pade; s*tf_cl_pade]);
    assignin('base', 'P', P);
    assignin('base', 'tau_0', delay);
%     assignin('base', 'gamma_tau', gamma_tau);
    assignin('base', 'ref_sys', ref_sys);
    assignin('base', 'ref_x0', [0]);
    assignin('base', 'gamma_x', gamma_x);
    assignin('base', 'k_x0', k_x0);
    out = sim('adaptive_mrac_e2y_delay');
    mrac_output = out.y;

end