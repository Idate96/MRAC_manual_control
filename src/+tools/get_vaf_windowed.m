function vaf_array = get_vaf_windowed(y, y_hat, window_size)
    half_wind_size = window_size/2;
    n = length(y_hat);
    vaf_array = zeros(1, n);
    for i = half_wind_size:(length(y) - half_wind_size)
        vaf_array(i) = tools.get_VAF(y(i - half_wind_size + 1: i + half_wind_size), y_hat(i - half_wind_size + 1: i + half_wind_size));
    end
    for i = n-half_wind_size:n
        vaf_array(i) = tools.get_VAF(y(i-half_wind_size:end), y_hat(i-half_wind_size:end));
    end
     vaf_array(1:half_wind_size) = tools.get_VAF(y(1:half_wind_size), y_hat(1:half_wind_size));
%     vaf_array(n - half_wind_size:end) = tools.get_VAF(y(n - half_wind_size:end), y_hat(n - half_wind_size:end));
end