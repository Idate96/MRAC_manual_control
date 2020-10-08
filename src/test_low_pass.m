A = pi/180.*[1.186, 1.121, 0.991, 0.756, 0.447, 0.245, 0.123, 0.061, 0.036, 0.025];
w = [0.23, 0.384, 0.614, 0.997, 1.687, 2.608, 4.065, 6.596, 10.661, 17.564];
phase = [0.974, -3.02, 0.744, -2.300, 2.984, -2.513, 2.211, 1.0, -2.225, 2.210];
    time = linspace(0, 90, 9000);
w2 = w.*2;

signal_run_1 = sum(A' .* sin(w'*time + phase'), 1);
signal_run_2 = sum(A' .* sin(w2'*time + phase'), 1);

params = [-0.1212;
    -0.09508;
    0.1302;
    1.7816;
    0.4585;
    4.8975;
    5.4729;
    0.9770];

case_ = 2;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];

ref_signal = timeseries(signal_run_2, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_lr_init_low_pass(params);
%%  steady state parameters for double the frequency 
params = [-0.0752;
    -0.0308;
    0.068;
    1.7816;
    0.4585;
    4.8975;
    5.4729;
    0.9770];

ref_signal = timeseries(signal_run_2, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_lr_init_low_pass(params);


