function plot_run(pilot_id, condition_id, run_id)
    load(join(['parsed_data/Data_Pil', num2str(pilot_id), '.mat']));
    data = eval(join(['data_cond', num2str(condition_id)]));
    
    fig = figure;
    subplot(4, 1, 1);
    plot(data.t(:, run_id), data.y1(:, run_id), data.t(:, run_id), data.ft1(:, run_id));
    legend('y1', 'ft1');
    
    subplot(4, 1, 2);
    plot(data.t(:, run_id), data.u1(:, run_id));
    legend('u1');
    
    subplot(4, 1, 3);
    plot(data.t(:, run_id), data.y2(:, run_id), data.t(:, run_id), data.ft2(:, run_id));
    legend('y2', 'ft2');
    
    subplot(4, 1, 4);
    plot(data.t(:, run_id), data.u2(:, run_id));
    legend('u2');
    
    pilot_dir = join(['images/pilot_', num2str(pilot_id)]);
    if ~exist(pilot_dir, 'dir')
       mkdir(pilot_dir)
    end
    condition_dir = join([pilot_dir, '/condition_', num2str(condition_id)]);
    if ~exist(condition_dir, 'dir')
       mkdir(condition_dir)
    end
    path = join([condition_dir, '/pilot_', num2str(pilot_id), '_cond_', num2str(condition_id), '_run_id_', num2str(run_id)]);
    savefig(fig, path);
end
