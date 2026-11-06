load data

col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];
col(3,:)=[0.9290 0.6940 0.1250];

p = [10 25 50 75 90];

gg=g/mean(mean(g(1,:,1:62), 'omitnan'), 'omitnan');
rr=r/mean(mean(r(1,:,1:62), 'omitnan'), 'omitnan');
mm=m/mean(mean(m(1,:,1:62), 'omitnan'), 'omitnan');

for n=1:2

    X=squeeze(gg(n,:,5:end-4));
    tt=squeeze(t(n,5:end-4));
    Q = prctile(X, p, 1);              
                                    % Q(1,:)=10th, Q(3,:)=median, Q(5,:)=90th

    mu    = mean(X, 1, 'omitnan');
    sigma = std(X, 0, 1, 'omitnan');   % flag 0 = normalize by N-1
    
    CV    = sigma ./ mu;

    subplot(3,2,1)
    hold on
    %plot(tt, X', 'Color', col(n,:), 'LineWidth', 0.5);   % 4th element = alpha
    band(tt, Q(1,:), Q(5,:), col(n,:), 0.12);
    band(tt, Q(2,:), Q(4,:), col(n,:), 0.25);
    plot(tt, Q(3,:), 'Color', col(n,:), 'LineWidth', 2);
    plot([0 0], [0 5], '--k', 'LineWidth', 2);
    axis([-4 12 0 2])
    set(gca,'FontSize',12,'XTick',[-4 0 4 8 12],'YTick',[0 1 2],'box','off')
    xlabel('Time (hours)','FontSize',15)
    ylabel('{\it rpoB} expr. (norm.)','FontSize',15)

    subplot(3,2,2)
    hold on
    %band(tt, CVci(1,:), CVci(2,:), col(n,:), 0.20);
    plot(tt, CV, 'Color', col(n,:), 'LineWidth', 2);
    %plot(tt, F, 'Color', col(n,:), 'LineWidth', 2);
    plot([0 0], [0 2], '--k', 'LineWidth', 2);
    %plot([-4 12], [1 1], '--k', 'LineWidth', 2);
    axis([-4 12 0 2])
    set(gca,'FontSize',12,'XTick',[-4 0 4 8 12],'YTick',[0 1 2],'box','off')
    xlabel('Time (hours)','FontSize',15)
    ylabel('{\it rpoB} CV','FontSize',15)

end

for n=1:2

    X=squeeze(rr(n,:,5:end-4));
    tt=squeeze(t(n,5:end-4));
    Q = prctile(X, p, 1);              
                                    % Q(1,:)=10th, Q(3,:)=median, Q(5,:)=90th

    mu    = mean(X, 1, 'omitnan');
    sigma = std(X, 0, 1, 'omitnan');   % flag 0 = normalize by N-1
    
    CV    = sigma ./ mu;

    subplot(3,2,3)
    hold on
    %plot(tt, X', 'Color', col(n,:), 'LineWidth', 0.5);   % 4th element = alpha
    band(tt, Q(1,:), Q(5,:), col(n,:), 0.12);
    band(tt, Q(2,:), Q(4,:), col(n,:), 0.25);
    plot(tt, Q(3,:), 'Color', col(n,:), 'LineWidth', 2);
    plot([0 0], [0 5], '--k', 'LineWidth', 2);
    axis([-4 12 0 3])
    set(gca,'FontSize',12,'XTick',[-4 0 4 8 12],'YTick',[0 1 2 3],'box','off')
    xlabel('Time (hours)','FontSize',15)
    ylabel('{\it mexXY} expr. (norm.)','FontSize',15)

    subplot(3,2,4)
    hold on
    %band(tt, CVci(1,:), CVci(2,:), col(n,:), 0.20);
    plot(tt, CV, 'Color', col(n,:), 'LineWidth', 2);
    %plot(tt, F, 'Color', col(n,:), 'LineWidth', 2);
    plot([0 0], [0 0.4], '--k', 'LineWidth', 2);
    %plot([-4 12], [1 1], '--k', 'LineWidth', 2);
    axis([-4 12 0 0.4])
    set(gca,'FontSize',12,'XTick',[-4 0 4 8 12],'YTick',[0 0.2 0.4],'box','off')
    xlabel('Time (hours)','FontSize',15)
    ylabel('{\it mexXY} CV','FontSize',15)

end

for n=1:2

    X=squeeze(mm(n,:,5:end-4));
    tt=squeeze(t(n,5:end-4));
    Q = prctile(X, p, 1);              
                                    % Q(1,:)=10th, Q(3,:)=median, Q(5,:)=90th

    mu    = mean(X, 1, 'omitnan');
    sigma = std(X, 0, 1, 'omitnan');   % flag 0 = normalize by N-1
    
    CV    = sigma ./ mu;

    subplot(3,2,5)
    hold on
    %plot(tt, X', 'Color', col(n,:), 'LineWidth', 0.5);   % 4th element = alpha
    band(tt, Q(1,:), Q(5,:), col(n,:), 0.12);
    band(tt, Q(2,:), Q(4,:), col(n,:), 0.25);
    plot(tt, Q(3,:), 'Color', col(n,:), 'LineWidth', 2);
    plot([0 0], [0 5], '--k', 'LineWidth', 2);
    axis([-4 12 0 4.2])
    set(gca,'FontSize',12,'XTick',[-4 0 4 8 12],'YTick',[0 2 4 6],'box','off')
    xlabel('Time (hours)','FontSize',15)
    ylabel('Scaled MexXY expr.','FontSize',15)

    subplot(3,2,6)
    hold on
    %band(tt, CVci(1,:), CVci(2,:), col(n,:), 0.20);
    plot(tt, CV, 'Color', col(n,:), 'LineWidth', 2);
    %plot(tt, F, 'Color', col(n,:), 'LineWidth', 2);
    plot([0 0], [0 0.4], '--k', 'LineWidth', 2);
    %plot([-4 12], [1 1], '--k', 'LineWidth', 2);
    axis([-4 12 0 0.4])
    set(gca,'FontSize',12,'XTick',[-4 0 4 8 12],'YTick',[0 0.2 0.4],'box','off')
    xlabel('Time (hours)','FontSize',15)
    ylabel('Scaled MexXY CV','FontSize',15)

end

function band(t, lo, hi, rgb, a)
    ok = isfinite(lo) & isfinite(hi);        % fill breaks on NaN
    fill([t(ok) fliplr(t(ok))], [lo(ok) fliplr(hi(ok))], rgb, ...
         'FaceAlpha', a, 'EdgeColor', 'none');
end