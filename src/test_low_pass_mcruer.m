time = linspace(0, 89.99, 90000);
params = [-0.089;
    -0.04;
    0.082;
    1.7816;
    0.4585;
    4.8975;
    5.4729;
    0.9770];

case_ = 2;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];
signal = models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_r2e(params);

%% steady staet for 7-3
params = [-0.089;
    -0.035;
    0.09;
    1.7816;
    0.4585;
    4.8975;
    5.4729;
    0.9770];

case_ = 2;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];
signal_73 = models.forcing_func_mcruer(time, "7-3");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_lr_init_low_pass(params);
%% steady state for 8-2
params = [-0.08;
    -0.02;
    0.065;
    1.7816;
    0.4585;
    4.8975;
    5.4729;
    0.9770];

case_ = 2;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];
signal_73 = models.forcing_func_mcruer(time, "8-2");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_resp
models.mrac_model_lr_init_low_pass(params);

%%  steady state for case 1
params = [-0.035;
    0.05;
    0.03;
    1.7816;
    0.4585;
    4.8975;
    5.4729;
    0.9770];

case_ = 1;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];
signal_73 = models.forcing_func_mcruer(time, "6-4");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_lr_init_low_pass(params);

%%  steady state for case 1 7-3
params = [-0.035;
    0.05;
    0.03;
    1.7816;
    0.4585;
    4.8975;
    5.4729;
    0.9770];

case_ = 1;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];
signal_73 = models.forcing_func_mcruer(time, "7-3");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_lr_init_low_pass(params);
%%  steady state for case 1 8-2
params = [-0.035;
    0.05;
    0.025;
    1.7816;
    0.4585;
    4.8975;
    5.4729;
    0.9770];

case_ = 1;

pilot_id = 3;
condition_id = 2;

ref_x0 = [0; 0; 0];
signal_73 = models.forcing_func_mcruer(time, "8-2");
ref_signal = timeseries(signal_73, time);
% [axis_data_1, ~] = preprocessing.get_mean_response(pilot_id, condition_id);
% ref_signal = axis_data_1.r;
models.mrac_model_lr_init_low_pass(params);

