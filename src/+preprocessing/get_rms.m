function [rms_e, rms_u] = get_rms(datafile)
    rms_e = (sum(datafile.data.DYNE.^2))^0.5;
    rms_u = (sum(datafile.data.DYNU.^2))^0.5;
end