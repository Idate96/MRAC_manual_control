function path = load_workspace(pilot_id, condition_id, filename)
    pilot_dir = join(['images/pilot_', num2str(pilot_id)]);
    condition_dir = join([pilot_dir, '/condition_', num2str(condition_id)]);
    path = join([condition_dir, '/', filename]);
    assignin('base', 'case_', condition_id);
end