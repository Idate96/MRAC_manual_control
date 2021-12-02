% set(groot,'defaultFigureVisible','on')
load('results/results_table_complete_lr.mat');
%%
column_names = {'Subject', 'VAF', 'Dataset', 'Dynamics'};

n = size(table_results, 1);
subjects = [table_results.Subject; table_results.Subject];
VAF = [table_results.("VAF u"); table_results.("VAF u Val.")];
Dataset = [repelem("Testing", n, 1); repelem("Validation", n, 1)];
Dynamics = [table_results.Dynamics; table_results.Dynamics];
Dynamics = strrep(Dynamics, '3', '121');
Dynamics = strrep(Dynamics, '4', '212');
long_table = table(subjects, VAF, Dataset, Dynamics, 'VariableNames', column_names);

long_table.Dynamics = categorical(long_table.Dynamics, {'1', '2', '121', '212'});
long_table.Dataset = categorical(long_table.Dataset);


boxchart(long_table.Dynamics, long_table.VAF, 'GroupByColor', long_table.Dataset);
ylabel("VAF u[-]");
xlabel("DYN");
ylim([0, 1]);
legend;
set(gca,'FontSize', 16);

exportgraphics(gcf, join(["results/images/box_plots/vaf_box.pdf"], ""));

%% initial gains box plots 
table_new = table_results;
Dynamics = table_results.Dynamics;
Dynamics = strrep(Dynamics, '3', '121');
Dynamics = strrep(Dynamics, '4', '212');
table_new.Dynamics = Dynamics;
table_new.Dynamics = categorical(table_new.Dynamics, {'1', '2', '121', '212'});
table_new.RMSE = double(table_new.RMSE);
table_new.RMSU = double(table_new.RMSU);
stat_array = grpstats(table_new, 'Dynamics', {'mean', 'std'}, 'Datavars',  {'RMSE'});

% table_new.('$K_{\dot{x}}$') = -table_new.('$K_{\dot{x}}$');
% table_new.('$K_x$') = - table_new.('$K_x$');
boxchart(table_new.Dynamics, table_new.RMSE * 180/pi);
ylabel("RMSE [deg]");
xlabel("DYN");
ylim([0, 1.5]);
% legend;
set(gca,'FontSize', 16);
exportgraphics(gcf, join(["results/images/box_plots/_box.pdf"], ""));

% hold;
% boxchart(table_new.Dynamics, table_new.RMSU);

% boxchart(table_new.Dynamics, table_new.('$\gamma_r$')); hold on;

%% learning rate box 
n = size(table_results, 1);
lr = [table_results.('$\gamma_x$'); table_results.('$\gamma_{\dot{x}}$'); table_results.('$\gamma_r$')];
lr_label = [repelem("$\gamma_{x1}$", n, 1); repelem("$\gamma_{x2}$", n, 1); repelem("$\gamma_r$", n, 1)];
Dynamics = [table_results.Dynamics; table_results.Dynamics; table_results.Dynamics];
Dynamics = strrep(Dynamics, '3', '121');
Dynamics = strrep(Dynamics, '4', '212');

learning_table = table(Dynamics, lr, lr_label);
learning_table.lr_label = categorical(learning_table.lr_label);
learning_table.Dynamics = categorical(learning_table.Dynamics,  {'121', '212'});
boxchart(learning_table.Dynamics, learning_table.lr, 'GroupByColor', learning_table.lr_label);
xlabel("DYN");
ylabel("lr");
legend('FontSize', 16, 'Interpreter', 'latex', 'location', 'northoutside', 'NumColumns', 3);
set(gca,'FontSize', 16);

exportgraphics(gcf, join(["results/images/box_plots/learning_box.pdf"], ""));

%%

column_names = {'Subject', 'Crossover', 'Delay', 'Dynamics'};


Dynamics = [table_results.Dynamics];
Dynamics = strrep(Dynamics, '3', '121');
Dynamics = strrep(Dynamics, '4', '212');
long_table = table(table_results.Subject, table_results.('$\omega_c$'), table_results.('$\tau$'), Dynamics, 'VariableNames', column_names);

long_table.Dynamics = categorical(long_table.Dynamics, {'1', '2', '121', '212'});
% long_table.Dataset = categorical(long_table.Dataset);


boxchart(long_table.Dynamics, long_table.Crossover);
ylabel("Crossover Freq. [rad/s]");
xlabel("Dynamics");
ylim([0, 4]);
set(gca,'FontSize', 16);

% legend;
exportgraphics(gcf, join(["results/images/box_plots/omega_box.pdf"], ""));

figure;
boxchart(long_table.Dynamics, long_table.Delay);
ylabel("Delay [s]");
xlabel("Dynamics");
ylim([0, 0.35]);
set(gca,'FontSize', 16);

% legend;
exportgraphics(gcf, join(["results/images/box_plots/tau_box.pdf"], ""));


