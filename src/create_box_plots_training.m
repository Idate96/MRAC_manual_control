set(groot,'defaultFigureVisible','on')
load('results/results_table_training.mat');
%%
table_results.Dynamics = categorical(table_results.Dynamics);
table_results.FOFU = categorical(table_results.FOFU);
boxchart(table_results.Dynamics, table_results.("VAF u"), 'GroupByColor', table_results.FOFU);
ylabel("VAF u[-]");
xlabel("Dynamics");
ylim([0, 1]);
legend;
exportgraphics(gcf, join(["results/images/box_plots/vaf_box.pdf"], ""));

%% initial gains box plots 
table_new = table_results;
Dynamics = table_results.Dynamics;
Dynamics = strrep(Dynamics, '3', '121');
Dynamics = strrep(Dynamics, '4', '212');
table_new.Dynamics = Dynamics;
table_new.Dynamics = categorical(table_new.Dynamics, {'121', '212'});
table_new.RMSE = double(table_new.RMSE);
table_new.('$K_{\dot{x}}$') = -table_new.('$K_{\dot{x}}$');
table_new.('$K_x$') = - table_new.('$K_x$');
boxchart(table_new.Dynamics, table_new.RMSE);
% boxchart(table_new.Dynamics, table_new.('$\gamma_r$')); hold on;

%% learning rate box 
n = size(table_results, 1);
lr = [table_results.('$\gamma_x$'); table_results.('$\gamma_{\dot{x}}$'); table_results.('$\gamma_r$')];
lr_label = [repelem("$\gamma_x$", n, 1); repelem("$\gamma_{\dot{x}}$", n, 1); repelem("$\gamma_r$", n, 1)];
Dynamics = [table_results.Dynamics; table_results.Dynamics; table_results.Dynamics];
Dynamics = strrep(Dynamics, '3', '121');
Dynamics = strrep(Dynamics, '4', '212');

learning_table = table(Dynamics, lr, lr_label);
learning_table.lr_label = categorical(learning_table.lr_label);
learning_table.Dynamics = categorical(learning_table.Dynamics,  {'121', '212'});
boxchart(learning_table.Dynamics, learning_table.lr, 'GroupByColor', learning_table.lr_label);
xlabel("Dynamics");
ylabel("Learning Rate");
legend('FontSize', 20, 'Interpreter', 'latex', 'location', 'northwest');
exportgraphics(gcf, join(["results/images/box_plots/learning_box.pdf"], ""));








