function disturbance_out = forcing_func_mcruer(time, type)
    T_sampling = 81.92;
    omega_0 =  2 * pi/T_sampling;
    prime_ids = [2, 3, 5, 7, 13, 19, 31, 53, 97, 177];
    phases = deg2rad([4, 151, 43, 122, 324, 184, 281, 194, 162, 43]); % deg
    A_1 = 0.8;
    A_2 = A_1/10^(0.5);
    if type == "7-3"
        amplitudes = deg2rad([A_1, A_1, A_1, A_1, A_1, A_1, A_1, A_2, A_2, A_2]); % deg
    elseif type == "8-2"
        amplitudes = deg2rad([A_1, A_1, A_1, A_1, A_1, A_1, A_1, A_1, A_2, A_2]); % deg
    elseif type == "6-4"
        amplitudes = deg2rad([A_1, A_1, A_1, A_1, A_1, A_1, A_2, A_2, A_2, A_2]); % deg
    end
    disturbance_out = 0;
    for i = 1:length(prime_ids)
        disturbance_out = disturbance_out + amplitudes(i) * sin(prime_ids(i) * omega_0 * time + phases(i));
    end
end