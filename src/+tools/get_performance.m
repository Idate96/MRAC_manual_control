function mse = get_performance(exp_data)

    start_idx = 10;
    f = 100;
    
    mse = (sum((exp_data.data.ft(start_idx * f:end) - exp_data.data.DYNX(start_idx * f:end)).^2)/length(exp_data.data.ft(start_idx * f:end)))^0.5;
end
