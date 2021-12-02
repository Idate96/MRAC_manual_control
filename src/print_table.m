clear all;
load('results/results_table.mat');
data = [table_results.RMSU, table_results.RMSE];

Subject = [];
for i = 1:size(table_results.Subject, 1)
    char_sub = char(table_results.Subject(i));
    Subject = [Subject; int8(round(str2num(char_sub(end))))];
end

Dynamics = table_results.Dynamics;
Dynamics = strrep(Dynamics, '3', '121');
Dynamics = strrep(Dynamics, '4', '212');
Dynamics = arrayfun(@str2num, Dynamics);

data = [Subject, Dynamics, data];
input.data = data;
input.dataformat = {'%s', '%s', '%.3f', '%.3f'};
tools.latexTable(input);

