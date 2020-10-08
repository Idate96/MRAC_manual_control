function mrac_output = mrac_model_const_ref(params)
    k_x0 = [-params(1); params(2)];
    k_r0 = params(3);
    gamma_x = params(4:5);
    gamma_r = params(6);
 
    assignin('base', 'gamma_x', gamma_x);
    assignin('base', 'gamma_r', gamma_r);
    assignin('base', 'k_r0', k_r0);
    assignin('base', 'k_x0', k_x0);
    out = sim('adaptive_mrac');
    mrac_output = out.y;
end