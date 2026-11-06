%% Color
col(1,:)=[0.8500 0.3250 0.0980]+0.1;
col(2,:)=col(1,:)-0.15;

%% Load chemostat and CFU data
fname = 'data.xlsx';
cfu_comp = readtable(fname,'Sheet','CFU700comp');

% Plate info
CFUs = zeros(size(cfu_comp,1),3);
for c = 1:size(cfu_comp,1)
    CFUs(c,:) = [table2array(cfu_comp(c,3:5))];
end

mCFUs = mean(CFUs,2,"omitnan");

datNames = ["Before drug","After drug"];

errCFU = zeros(size(CFUs,1),1);

for p = 1:size(CFUs,1)
    errCFU(p) = std(CFUs(p,:));
end

%% Make barplots with datapoints
figure;
hold on

b1 = bar(1,mCFUs(1),'FaceColor',col(1,:),'EdgeColor',[0 0 0],'LineWidth',2);
b2 = bar(2,mCFUs(5),'FaceColor',col(2,:),'EdgeColor',[0 0 0],'LineWidth',2);

scatter(ones(3,1),CFUs(1,:),100,'filled','MarkerFaceAlpha',1,'jitter','on','jitteramount',0.15,'MarkerFaceColor',col(1,:),'MarkerEdgeColor',[0,0,0],'LineWidth',2)
scatter(ones(3,1)*2,CFUs(5,:),100,'filled','MarkerFaceAlpha',1,'jitter','on','jitteramount',0.15,'MarkerFaceColor',col(2,:),'MarkerEdgeColor',[0,0,0],'LineWidth',2)

errorbar(1,mCFUs(1),errCFU(1,:),'LineStyle','none','Color','black','LineWidth', 3,'CapSize',14);
errorbar(2,mCFUs(5),errCFU(5,:),'LineStyle','none','Color','black','LineWidth', 3,'CapSize',14);

%% Plot stats
ylabel('Δ{\itmexZ} relative abundance')
set(gca,'XTick',[1 2],'XTickLabels',{"Before drug","After drug"})
set(findall(gcf,'-property','FontSize'),'FontSize',25)
hold on

% ttest: [rejected/accepted, p-value]
[~,pT] = ttest2(CFUs(1,:),CFUs(5,:));
if pT < 0.05

    % STYLISHLY add stats to current plot using ritzStar
    newY = ritzStar([1 2],pT,0.9);
    
end

ylim([0 newY+newY/10])
hold off

