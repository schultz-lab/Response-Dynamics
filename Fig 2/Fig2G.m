%% load datasets

load data

datNames = ["WT","\Delta{\itmexZ}"];

col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];

comparisons = [...
    1 2];

minusFrame = 23;
idx2 = find(t(1,:)==12);


%% check if normal assumption holds before ttest.. user will be alerted if not
% h is binary yes/no if reject null of not normal. p is p-value

for k = 1:2
    normCheck = mean(m(k,:,end-minusFrame:end),3,"omitnan");
    [h(k),p(k)] = adtest(normCheck);
end

if ~all(h)
    disp('Normal distribution assumption is valid for all datasets.')
else
    nonNorm = datNames(h==0);
    disp('Normal distribution assumption is rejected for: ')
    for n = 1:size(nonNorm,2)
        disp(string(nonNorm{n}))
    end
end
%% Make boxplots
figure;
hold on

% mexXY data column concatenated with category column
dat = [mean(m(1,:,idx2-minusFrame:idx2),3,"omitnan")' ones(size(c,2),1)];
dat = [dat;[mean(m(2,:,idx2-minusFrame:idx2),3,"omitnan")' ones(size(c,2),1)*2]];

% WT exp
dat1 = mean(m(1,:,idx2-minusFrame:idx2),3,"omitnan")';

% KOmexZ exp
dat2 = mean(m(2,:,idx2-minusFrame:idx2),3,"omitnan")';

for b = 1:2
    idxBox = dat(:,2) == b;
    datBox = dat(idxBox,1);
    catBox = dat(idxBox,2);
    
    
    % set boxchart marker size to ~0.. set equal to variable for legend
    if b == 1
        b1 = boxchart(catBox,datBox,'JitterOutliers','off','BoxFaceColor',col(b,:),'MarkerColor',col(b,:),'MarkerSize',0.0001,'BoxFaceAlpha',0.7,'BoxEdgeColor',[0,0,0],'LineWidth',2);
    else
        b2 = boxchart(catBox,datBox,'JitterOutliers','off','BoxFaceColor',col(b,:),'MarkerColor',col(b,:),'MarkerSize',0.0001,'BoxFaceAlpha',0.7,'BoxEdgeColor',[0,0,0],'LineWidth',2);
    end
    scatter(catBox,datBox,100,'filled','MarkerFaceAlpha',1,'jitter','on','jitteramount',0.15,'MarkerFaceColor',col(b,:),'MarkerEdgeColor',[0,0,0],'LineWidth',2)

end
%% Plot stats
ylabel('MexXY expr. (norm.)')
%l=legend([b1,b2],datNames,'Location','northeast','AutoUpdate','off');
set(gca,'XTick',[1 2],'XTickLabels',{"WT","\Delta{\itmexZ}"})
set(findall(gcf,'-property','FontSize'),'FontSize',25)
hold on

% ttest: [rejected/accepted, p-value]
[~,pT] = ttest2(dat1,dat2);
if pT < 0.05

    % STYLISHLY add stats to current plot using ritzStar
    newY = ritzStar(comparisons,pT,5);
    
end

ylim([0 newY+newY/10])
hold off

