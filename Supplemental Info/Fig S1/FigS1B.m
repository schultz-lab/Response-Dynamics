%% Load data and color scheme
load data

col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];
col(3,:)=[0.9290 0.6940 0.1250];
%% Layer histograms on top of each other
figure(4)
for s = [3,2,1]
    plotL = squeeze(x(s,:,:));
    Lminus1 = NaN((size(plotL,2)-1)*size(plotL,1),1);
    L = NaN((size(plotL,2)-1)*size(plotL,1),1);
    
    count = 1;
    for c = 1:size(plotL,1)
        for f = 2:size(plotL,2)
            L(count) = plotL(c,f);
            Lminus1(count) = plotL(c,f-1);
            count = count+1;
        end
    end

    % define as variable so I can label legend
    if s == 3
        h3 = histogram(log2(L./Lminus1),40,'FaceColor',col(s,:),'FaceAlpha',0.7);
    elseif s == 2
        h2 = histogram(log2(L./Lminus1),40,'FaceColor',col(s,:),'FaceAlpha',0.7);
    else
        h1 = histogram(log2(L./Lminus1),40,'FaceColor',col(s,:),'FaceAlpha',0.7);
    end
    hold on
end
ylim([0 2500])
y=ylim;

% Vertical line where doubling is called
doubFac = log2(0.71);
plot([doubFac doubFac],[y(1) y(2)],'--k','LineWidth',6)
xlim([-2 2])

ylabel('Count')
xlabel('log_2(size_{n+1} / size_n)')

legend([h1,h2,h3],'WT','Δ{\itmexZ}','Δ{\itmexY}','Location','northeast');
set(findall(gcf,'-property','FontSize'),'FontSize',44)
hold off

