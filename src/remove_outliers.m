clear all;
load('results/results_table_complete.mat');
table_results([1, 4, 21, 31], :) = [];
save('results/results_table_wo_outliers.mat', 'table_results');