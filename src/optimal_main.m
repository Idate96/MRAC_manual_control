conditions = [1, 2, 3, 6];
for pilot_id = 1:9
   for condition = conditions
       cases.optimize_case(pilot_id, condition)
   end
end