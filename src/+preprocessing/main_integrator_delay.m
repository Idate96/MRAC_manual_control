%%
[y_target, r, t] = get_mean_response(3, 1);
ref_signal = timeseries(r, t);
model_func = @models.integrator_delay;
find_mse_func = @(model_params) find_mse(ref_signal, y_target, model_func, model_params);
params_0 = [1, 0.32];
params_opt = fmincon(find_mse_func, params_0, [],[],[],[],[0, 0.2],[10, 0.9]);
mse_1 = find_mse_func(params_opt);
%%
[y_opt, t] = lsim(model_func(params_opt), ref_signal.Data, ref_signal.Time);

fig1 = figure;
plot(t, y_target, t_1, y_opt, t_1, ref_signal.Data, 'LineWidth', 2);
title(strcat('MSE= ', num2str(mse_1, 3)));
xlabel('Time [s]');
ylabel('Amplitude [deg]');
legend('y', 'y_{model}', 'r');
saveas(fig1, 'images/second_order_model_ref.png');
% 
% a = find_mse_func([params_opt]);
% b = find_mse_func([1.0, 0.32]);
% 
% [y_b, t] = lsim(model_func([2.5, 0.4]), ref_signal.Data, ref_signal.Time);
% figure;
% plot(t, y_target, t, y_b, t, ref_signal.Data);
% legend('y', 'y_b', 'r');

%%
[y_target, r, t] = get_mean_response(3, 2);
ref_signal = timeseries(r, t);
model_func = @models.integrator_delay;
find_mse_func = @(model_params) find_mse(ref_signal, y_target, model_func, model_params);
params_0 = [1, 0.32];
params_opt = fmincon(find_mse_func, params_0, [],[],[],[],[0, 0.2],[10, 0.9]);
mse_2 = find_mse_func(params_opt);

%%
[y_opt, t] = lsim(model_func(params_opt), ref_signal.Data, ref_signal.Time);

fig1 = figure;
plot(t, y_target, t_1, y_opt, t, ref_signal.Data, 'LineWidth', 2);
title(strcat('MSE= ', num2str(mse_2, 3)));
xlabel('Time [s]');
ylabel('Amplitude [deg]');
legend('y', 'y_{model}', 'r');
saveas(fig1, 'images/first_order_model_ref.png');
% 
a = find_mse_func([params_opt]);
% b = find_mse_func([1.0, 0.32]);
% 
% [y_b, t] = lsim(model_func([2.5, 0.4]), ref_signal.Data, ref_signal.Time);
% figure;
% plot(t, y_target, t, y_b, t, ref_signal.Data);
% legend('y', 'y_b', 'r');

