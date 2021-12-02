function mseu = find_mseu_mrac_pursuit(human_output, system_output, model, model_params_norm, lb, up)
    mse = fitting.find_mse_mrac_pursuit(system_output,  model, model_params_norm, lb, up);
    msu = fitting.find_msu_mrac_pursuit(human_output, model, model_params_norm, lb, up);
    
    lambda_ = 10;
    
    mseu = msu + lambda_ * mse;
end

