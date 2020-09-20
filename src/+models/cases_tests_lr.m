s = tf('s');
a = 3;
sys_ol = a/(s) * exp(-0.3 * s);
tf_cl_ = feedback(sys_ol, 1);
tf_ol_pade = pade(sys_ol, 1);
tf_cl_pade = feedback(tf_ol_pade, 1);

ref_sys = ss([tf_cl_pade; s*tf_cl_pade]);
ref_sys = canon(ref_sys, 'modal');
P = lyap(ref_sys.A', eye(2));
plant_case = 1;

%% Learning Rate Sensitivity
% good values for adaptive-mrac-state-space gr = 0.1, gx = [-1, -1]
gamma_x_0 = [0.005; 0.005];
gamma_r_0 = 0.01;
plant_case = 0;
% sim('adaptive_mrac_state_space_cases');
for j = 1:1
    plant_case = j;
    % monte carlo sims 
    for i = 1:10:100
        gamma_x = gamma_x_0 * i;
        gamma_r = gamma_r_0 * i;
        name = join(['plant', num2str(plant_case), '_gr_', num2str(gamma_r), '_gx_', num2str(gamma_x(1))]);
        out = sim('adaptive_mrac_state_space_cases');
        plotting.plot_outputs(out, name);
    end
end