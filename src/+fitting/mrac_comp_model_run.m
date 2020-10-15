function [model_output] = mrac_comp_model_run(reference_signal, model, params)
    assignin('base', 'ref_signal', reference_signal);
    model_output = model(params);
end