function plot_condition(pilot_id, condition_id)
    set(0,'DefaultFigureVisible','off')
    load(join(['parsed_data/Data_Pil', num2str(pilot_id), '.mat']));
    data = eval(join(['data_cond', num2str(condition_id)]));
    
    num_runs = size(data.t, 2);
    for i = 1:num_runs
        plot_run(pilot_id, condition_id, i)
    end
end