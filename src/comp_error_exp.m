pilot_id = 3;
condition_id = 3;
[axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
error = axis_data_1.r - axis_data_1.y;
plot(axis_data_1.r, 'lineWidth', 2); 
hold on;
plot(axis_data_1.y, 'lineWidth', 2);
% hold on;
% plot(error);
legend('r', 'y', 'e');

case_ = condition_id;
ref_signal =  axis_data_1.r ;
k_x0 = [10; 0]/100;
P_0 = [1, 2];
gamma_x0 = 20*[5; 10]/100;
model_func = @models.mrac_model_lr_init_comp;
omega_c0 = 3;
delay_0 = 0.3;
params_0 = [k_x0(1); k_x0(2); P_0'; omega_c0; delay_0; gamma_x0; gamma_r0];
models.mrac_model_lr_init_low_pass_comp(params_0);



