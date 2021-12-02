idx = 1:13;
time = linspace(0, 90, 100*90);

for id = idx
    func = preprocessing.load_forcing_fun(id);
    timeseries = func(time);
end