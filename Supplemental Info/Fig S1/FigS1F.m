%% load datasets

load data

datNames = ["Before drug","After drug"];

col(1,:)=[1 0 1];
col(2,:)=[1 1 1];


%% Make boxplots
figure;
hold on

% growth data before drug concatenated with category column
idx1 = find(t==0);
holdDat1 = mean(g(:,1:idx1),2,"omitnan");
holdDat1 = [holdDat1 ones(size(holdDat1,1),1)];

% growth data after drug concatenated with category column
holdDat2 = mean(g(:,idx1+24:idx1+48),2,"omitnan");
holdDat2 = [holdDat2 2*ones(size(holdDat2,1),1)];

dat = [holdDat1;holdDat2];

for b = 1:2
    idxBox = dat(:,2) == b;
    datBox = dat(idxBox,1);
    catBox = dat(idxBox,2);
    
    % set non-displaying line equal to variable for legend
    if b == 1
        b1 = boxchart(catBox,datBox,'JitterOutliers','off','BoxFaceColor',col(b,:),'MarkerColor',col(b,:),'MarkerSize',0.0001,'BoxEdgeColor',[0,0,0],'BoxFaceAlpha',0.7,'LineWidth',6);
    elseif b == 2
        b2 = boxchart(catBox,datBox,'JitterOutliers','off','BoxFaceColor',col(b,:),'MarkerColor',col(b,:),'MarkerSize',0.0001,'BoxEdgeColor',[0,0,0],'LineWidth',6);
    end
    % set boxchart marker size to ~0..
    scatter(catBox,datBox,300,'filled','MarkerFaceAlpha',1,'jitter','on','jitteramount',0.15,'MarkerFaceColor',col(b,:),'MarkerEdgeColor',[0,0,0],'LineWidth',6)

end

xlim([0.5 2.5])

%% Plot stats

ylabel('Growth (doub./hr)')
l=legend([b1,b2],datNames,'Location','southwest','AutoUpdate','off');
xticks([])
set(findall(gcf,'-property','FontSize'),'FontSize',44)

% 2-tail t-test
[h,p] = ttest2(dat(dat(:,2)==1),dat(dat(:,2)==2),'Tail','both','Alpha',0.05);

% STYLISHLY add stats to current plot using ritzStar
newY = ritzStar([1,2],p,1.5);

ylim([-0.1 newY+newY/10])
hold off

