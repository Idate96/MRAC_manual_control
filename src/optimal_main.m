conditions = [3];
for pilot_id = 3
   for condition = conditions
       cases.optimize_case_comp(pilot_id, condition)
   end
end
