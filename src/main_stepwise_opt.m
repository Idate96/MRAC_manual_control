conditions = [3];
pilot_ids = [3];
for pilot_id = pilot_ids
   for condition = conditions
       cases.step_optimization(pilot_id, condition)
   end
end

%% run model 
