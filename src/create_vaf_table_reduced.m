column_names = {'Subject', 'Dynamics', 'VAF y', 'VAF u', 'RMSE', 'RMSU', ...
                '$K_x$','$K_{\dot{x}}$', '$k_r$', '$\omega_c$', '$\tau$', '$\gamma_x$', '$\gamma_{\dot{x}}$', '$\gamma_r$'};

set(groot,'defaultFigureVisible','off')
subjects = ["Subject00", "Subject01", "Subject03", "Subject04", "Subject05", "Subject06", "Subject08", "Subject09"];
% subjects = ["Subject02"];
conditions = ["fofu6_dyn3", "fofu7_dyn4"]; 
vafs_u_t = [];   
vafs_y_t = [];
subject_t = [];
dyn_t = [];
mse_t = [];
msu_t = [];

optimal_params_t = [];

for subject = subjects
    for condition = conditions
        common_name = join([subject, "_", condition], "");
        path = join(["results/tests/", subject, "/", common_name, "red_or_.mat"], "");
        if isfile(path)
            load(path);
            mkdir(join(["results/images/", subject], ""));

            [vaf_y, vaf_u, params] = tools.get_run_data(exp_data, model_func, optimal_param);
            mse = tools.get_performance(exp_data);
            msu = tools.get_control_activity(exp_data);
            mse_t = [mse_t; mse];
            msu_t = [msu_t; msu];
            vafs_u_t = [vafs_u_t; vaf_u];
            vafs_y_t = [vafs_y_t; vaf_y];
            char_cond = char(condition);
            dyn_t = [dyn_t; char_cond(end)];
            subject_t = [subject_t; subject];
            optimal_params_t = [optimal_params_t; params'];
        end
    end
end

%%
% variables = [subject_t dyn_t, vafs_y_t, vafs_u_t, vafs_u_val_t, vafs_y_val_t];
table_results_red = table(subject_t, dyn_t, vafs_y_t, vafs_u_t, mse_t, msu_t, ...
                      optimal_params_t(:, 1), optimal_params_t(:, 2), optimal_params_t(:, 3), optimal_params_t(:, 4), optimal_params_t(:, 5), ...
                      optimal_params_t(:, 6), optimal_params_t(:, 7), optimal_params_t(:, 8), 'VariableNames', column_names);
         
%%
save('results/results_table_red.mat', 'table_results_red');