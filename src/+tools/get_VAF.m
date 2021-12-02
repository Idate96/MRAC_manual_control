function vaf = get_VAF(y, y_hat)
    vaf = 1 - var(y - y_hat)/var(y);
end