column_names = {'Subject', 'Dynamics', 'VAF y', 'VAF u', 'RMSE', 'RMSU', 'VAF y Val.', 'VAF u Val.', 'RMSE Val.', 'RMSU Val.', ...
                '$K_x$','$K_{\dot{x}}$', '$k_r$', '$\omega_c$', '$\tau$', '$\gamma_x$', '$\gamma_{\dot{x}}$', '$\gamma_r$'};

set(groot,'defaultFigureVisible','off')
subjects = ["Subject00", "Subject01", "Subject02", "Subject03", "Subject04", "Subject05", "Subject06", "Subject07", "Subject08", "Subject09"];
% subjects = ["Subject02"];
fofus = ["6", "7"];
dyns = ["1", "2", "3", "4"];
vafs_u_t = [];   
vafs_y_t = [];
subject_t = [];
dyn_t = [];
vafs_u_val_t = [];
vafs_y_val_t = [];
mse_t = [];
msu_t = [];
mse_val_t = [];
msu_val_t = [];
optimal_params_t = [];

for subject = subjects
    for fofu = fofus
        for dyn = dyns
            common_name = join([subject, "_fofu", fofu, "_dyn", dyn], "");
            path = join(["results/tests/", subject, "/", common_name, "delay_u_lr.mat"], "");
            
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
                dyn_t = [dyn_t; dyn];
                subject_t = [subject_t; subject];
                optimal_params_t = [optimal_params_t; params'];
                if (dyn == "3" || dyn == "4")
                    if fofu == "6"
                        val_fofu = "10";
                    elseif fofu == "7"
                        val_fofu = "11";
                    end

                    path_val = "data/mean_responses/" + subject + "_fofu" + val_fofu + "_dyn" + dyn + ".mat";
                    load(path_val);
                    mse_val = tools.get_performance(exp_data);
                    msu_val = tools.get_control_activity(exp_data);
                    mse_val_t = [mse_val_t; mse_val];
                    msu_val_t = [msu_val_t; msu_val];
                    [vaf_y, vaf_u, ~] = tools.get_run_data(exp_data, model_func, optimal_param);
                    vafs_u_val_t = [vafs_u_val_t; vaf_u];
                    vafs_y_val_t = [vafs_y_val_t; vaf_y];
                    
                else
                    vafs_u_val_t = [vafs_u_val_t; nan];
                    vafs_y_val_t = [vafs_y_val_t; nan];
                    mse_val_t = [mse_val_t; nan];
                    msu_val_t = [msu_val_t; nan];
                end
            end
        end
    end
end
%%
% variables = [subject_t dyn_t, vafs_y_t, vafs_u_t, vafs_u_val_t, vafs_y_val_t];
table_results = table(subject_t, dyn_t, vafs_y_t, vafs_u_t, mse_t, msu_t, vafs_y_val_t, vafs_u_val_t, mse_val_t, msu_val_t, ...
                      optimal_params_t(:, 1), optimal_params_t(:, 2), optimal_params_t(:, 3), optimal_params_t(:, 4), optimal_params_t(:, 5), ...
                      optimal_params_t(:, 6), optimal_params_t(:, 7), optimal_params_t(:, 8), 'VariableNames', column_names);
         
%%
save('results/results_table_complete_lr.mat', 'table_results');