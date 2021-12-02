function mse = get_control_activity(exp_data)
    start_idx = 10;
    f = 100;
    mse = (sum((exp_data.data.DYNU(start_idx * f:end)).^2)/length(exp_data.data.DYNU(start_idx * f:end)))^0.5;
end
