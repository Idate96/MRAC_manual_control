function [model_output] = mrac_model_run(reference_signal, model, params)
    assignin('base', 'ref_signal', reference_signal);
    params(1) = -params(1);
    model_output = model(params);
end