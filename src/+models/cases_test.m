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
k_x0_list = [-15, -15, -15, -10; 9, -5, -5, 0];
k_r0_list = [15, 15, 15, 20];
% P_r for case 1 - 2 is [0.1 , 0.4]

beta_ = 1;
gamma_x = [0.5; 0.5];
gamma_r = 0.03;
plant_case = 1;

k_x0 = k_x0_list(:, plant_case);
k_r0 = k_r0_list(:, plant_case);

name = join(['cases/plant', num2str(plant_case), '_gr_', num2str(gamma_r), '_gx_', num2str(gamma_x(1))]);
out = sim('adaptive_mrac');
plotting.plot_outputs(out, name);
