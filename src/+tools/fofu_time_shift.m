function forcing_fun = fofu_time_shift(realization_num, T, gain, time_sense, name)
    [fofu_name, ~, ~] = preprocessing.fofuid_2_runvars(realization_num);
    period = 30;
    path = "data/forcing_fun/" + fofu_name;
    data = table2array(readtable(path, 'Delimiter', "\t"));

    frequencies = 2*pi/period * data(:, 1);
    amplitudes = time_sense * gain * data(:, 2);
    phases = (time_sense) * mod(data(:, 3) + (frequencies * T), 2 * pi) ;
    data(:, 3) = phases;
    data(:, 2) = amplitudes;
    
    path = "data/forcing_fun/" + name + fofu_name;
    writetable(array2table(data), path, 'Delimiter', "\t");
    forcing_fun = @(t) sum(amplitudes .* sin(frequencies .* t + phases), 1);
end




