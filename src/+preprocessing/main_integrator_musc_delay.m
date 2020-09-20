%% second order system 
[y_target_2, r_2, t_2] = get_mean_response(3, 2);
ref_signal_2 = timeseries(r_2, t_2);
model_func = @models.integrator_muscular_delay;
find_mse_func = @(model_params) find_mse(ref_signal_2, y_target_2, model_func, model_params);
params_0_2 = [1, 0.32, 8, 0.7];
params_opt_2 = fmincon(find_mse_func, params_0_2, [],[],[],[], [0, 0.2, 8, 0.7], [10, 0.9, 8, 0.7]);

%%
[y_opt_2, t_2] = lsim(model_func(params_opt_2), ref_signal_2.Data, ref_signal_2.Time);

% figure;
% title('');
% plot(t_2, y_target_2, t_2, y_opt_2, t_2, ref_signal_2.Data, 'LineWidth', 2);
% legend('y', 'y_opt', 'r');

params_manual_2 = [2.55, 0.33, 8, 0.7];
[y_b, t_2] = lsim(model_func(params_manual_2), ref_signal_2.Data, ref_signal_2.Time);

mse_opt = find_mse_func(params_opt_2);
mse_manual = find_mse_func(params_manual_2);

fig = figure;
plot(t_2, y_target_2, t_2, y_b, t_2, ref_signal_2.Data, 'LineWidth', 2);
title(strcat('MSE= ', num2str(mse_opt, 3)));
xlabel('Time [s]');
ylabel('Amplitude [deg]');
legend('y', 'y_{model}', 'r');
saveas(fig, 'images/second_order_model_ref_musc.png');

 
%% first order system 
[y_target_1, r_1, t_1] = get_mean_response(3, 1);
ref_signal_1 = timeseries(r_1, t_1);
model_func = @models.integrator_muscular_delay;
find_mse_func = @(model_params) find_mse(ref_signal_1, y_target_1, model_func, model_params);
params_0_1 = [1, 0.32, 10, 0.7];
params_opt_1 = fmincon(find_mse_func, params_0_1, [],[],[],[], [0, 0.2, 0, 0], [10, 0.9, 10, 1]);


%%
[y_opt_1, t_1] = lsim(model_func(params_opt_1), ref_signal_1.Data, ref_signal_1.Time);
mse_1 = find_mse_func(params_opt_1);

fig1 = figure;
plot(t_1, y_target_1, t_1, y_opt_1, t_1, ref_signal_1.Data, 'LineWidth', 2);
title(strcat('MSE= ', num2str(mse_1, 3)));
xlabel('Time [s]');
ylabel('Amplitude [deg]');
legend('y', 'y_{model}', 'r');
saveas(fig1, 'images/first_order_model_ref_musc.png');
% 
% 
% [y_b, t_1] = lsim(model_func([1.15, 0.2, 10, 0.7]), ref_signal_1.Data, ref_signal_1.Time);
% figure;
% plot(t_1, y_target_1, t_1, y_b, t_1, ref_signal_1.Data);
% legend('y', 'y_b', 'r');