function plot_pilot(pilot_id)
    set(0,'DefaultFigureVisible','off')
    data = load(join(['parsed_data/Data_Pil', num2str(pilot_id), '.mat']));
    field_names = fieldnames(data);
    for i = 1:numel(field_names)
        cell_name = join(['data.', field_names(i)], '');
        plot_condition_(pilot_id, i, eval(cell_name{1}));
    end
end

function plot_condition_(pilot_id, condition_id, data)
    num_runs = size(data.t, 2);
    for i = 1:num_runs
        plot_run_(pilot_id, condition_id, i, data)
    end
end

function plot_run_(pilot_id, condition_id, run_id, data)    
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
    path = join([condition_dir, '/pilot_', num2str(pilot_id), '_cond_', num2str(condition_id), '_run_id_', num2str(run_id), '.png']);
    saveas(fig, path);
end
