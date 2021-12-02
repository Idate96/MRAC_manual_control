clear all;
x = linspace(0,90, 90 * 100);
y = sin(x);
test_plot = plot(x,y);

tools.plot_areas(test_plot, '212')
% 
% 
% p1 = patch([0 0 30 30],[-1 1 1 -1],'');
% set(p1,'FaceAlpha',0.1)
% set(p1,'EdgeColor','none')
% set(p1, 'DisplayName', '2');
% 
% p2 = patch([30 30 60 60],[-1 1 1 -1],'');
% set(p2,'FaceAlpha',0.0)
% set(p2,'EdgeColor','k')
% set(p2, 'DisplayName', '1');
% 
% p3 = patch([60 60 90 90],[-1 1 1 -1],'');
% set(p3,'FaceAlpha',0.1)
% set(p3,'EdgeColor','none')
% set(p3, 'DisplayName', '2');
% 
% 
% legend([p1, p2])