function plot_areas_red(figure_input, cond, path)
    xLimits = get(gca,'XLim');  %# Get the range of the x axis
    yLimits = get(gca,'YLim');  %# Get the range of the y axis
    y_min = yLimits(1);
    y_max = yLimits(2);
    T1 = 30;
    T2 = 60;
    
    if cond == "4"
        
        sq1 = [0 T2; 0 T2; T1 90; T1 90];
        sq2 = [y_min y_min; y_max y_max; y_max y_max; y_min y_min];
        p1 = patch(sq1, sq2,'');
        set(p1,'FaceAlpha',0.1)
        set(p1,'EdgeColor','none')
        set(p1, 'DisplayName', 'DYN 2');

        p2 = patch([T1 T1 T2 T2],[y_min y_max y_max y_min],'');
        set(p2,'FaceAlpha',0.0)
        set(p2,'EdgeColor','k')
        set(p2, 'DisplayName', 'DYN 1');
        


%         p3 = patch([T2 T2 90 90],[y_min y_max y_max y_min],'');
%         set(p3,'FaceAlpha',0.1)
%         set(p3,'EdgeColor','none')
% %         set(p3, 'DisplayName', '2');
%         leg = legend([p1, p2], 'Location', 'northwest');
%         title(leg, 'Dynamics' );

        
    elseif cond == "3"
        sq1 = [0 T2; 0 T2; T1 90; T1 90];
        sq2 = [y_min y_min; y_max y_max; y_max y_max; y_min y_min];
        p1 = patch(sq1, sq2,'');        set(p1,'FaceAlpha',0.0)
        set(p1,'EdgeColor','k')
        set(p1, 'DisplayName', 'DYN 1');

        p2 = patch([T1 T1 T2 T2],[y_min y_max y_max y_min],'');
        set(p2,'FaceAlpha',0.1)
        set(p2,'EdgeColor','none')
        set(p2, 'DisplayName', 'DYN 2');

%         p3 = patch([T2 T2 90 90],[y_min y_max y_max y_min],'');
%         set(p3,'FaceAlpha',0.0)
%         set(p3,'EdgeColor','k')
%         set(p3, 'DisplayName', '1');
%         leg = legend([p1, p2], 'Location', 'northwest');
%         title(leg, "Dynamics");

    else 
    end
    xlim([0, 60]);
end