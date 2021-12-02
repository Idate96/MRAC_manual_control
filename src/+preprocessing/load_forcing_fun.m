function forcing_fun = load_forcing_fun(realization_num)
    [fofu_name, ~, ~] = preprocessing.fofuid_2_runvars(realization_num);
    period = 30;
    path = "data/forcing_fun/" + fofu_name;
    data = table2array(readtable(path, 'Delimiter', "\t"));

    frequencies = 2*pi/period * data(:, 1);
    amplitudes = data(:, 2);
    phases = data(:, 3);

    forcing_fun = @(t) sum(amplitudes .* sin(frequencies .* t + phases), 1);
end








