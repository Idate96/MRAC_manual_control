function [model_output] = model_run(ref_signal, model)
    [y, t] = lsim(model, ref_signal.Data, ref_signal.Time);
    model_output = timeseries(y, t);
end