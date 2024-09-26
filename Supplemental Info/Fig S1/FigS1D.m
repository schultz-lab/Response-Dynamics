%% load datasets

load data

datNames = ["Arrested","Moribund","Recovered"];

col(1,:)=[0 0 0];
col(2,:)=[0.4660 0.6740 0.1880];
col(3,:)=[0.6350 0.0780 0.1840];

comparisons = [...
    1 2;...
    1 3;...
    2 3];

minusFrame = 13;
idx2 = find(t(1,:)==12);


%% check if normal assumption holds before ANOVA.. user will be alerted if not
% h is binary yes/no if reject null of not normal. p is p-value

% Turn off warning for too low of a p-value on normal (ad) test
warning('off','stats:adtest:OutOfRangePLow');

for k = 1:3
    ii=find(j==k);
    normCheck = mean(m(ii,end-minusFrame:end),"omitnan");
    [h(k),p(k)] = kstest(normCheck);
end

if all(h)
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
dat = [mean(m(:,idx2-minusFrame:idx2),2,"omitnan") j'];

for b = 1:3
    idxBox = dat(:,2) == b;
    datBox = dat(idxBox,1);
    catBox = dat(idxBox,2);
    
    
    % set boxchart marker size to ~0.. set equal to variable for legend
    if b == 1
        b1 = boxchart(catBox,datBox,'JitterOutliers','off','BoxFaceColor',col(b,:),'MarkerColor',col(b,:),'MarkerSize',0.0001,'BoxFaceAlpha',0.7,'BoxEdgeColor',[0,0,0],'LineWidth',6);
    elseif b == 2
        b2 = boxchart(catBox,datBox,'JitterOutliers','off','BoxFaceColor',col(b,:),'MarkerColor',col(b,:),'MarkerSize',0.0001,'BoxFaceAlpha',0.7,'BoxEdgeColor',[0,0,0],'LineWidth',6);
    else
        b3 = boxchart(catBox,datBox,'JitterOutliers','off','BoxFaceColor',col(b,:),'MarkerColor',col(b,:),'MarkerSize',0.0001,'BoxFaceAlpha',0.7,'BoxEdgeColor',[0,0,0],'LineWidth',6);
    end
    scatter(catBox,datBox,300,'filled','MarkerFaceAlpha',1,'jitter','on','jitteramount',0.15,'MarkerFaceColor',col(b,:),'MarkerEdgeColor',[0,0,0],'LineWidth',6)

end
%% Plot stats
ylabel('MexXY expr. (norm.)')
l=legend([b1,b2,b3],datNames,'Location','southeast','AutoUpdate','off');
xticks([])
set(findall(gcf,'-property','FontSize'),'FontSize',44)
hold on

% ANOVA: 1st input -> data, 2nd input -> grouping
% assume alphas = 0.05
pANOVA = anova1(dat(:,1),dat(:,2),"off");
if pANOVA < 0.05
    [~,~,stats] = anova1(dat(:,1),dat(:,2),'off');
    c = multcompare(stats,'Display','off','CriticalValueType','dunn-sidak');
    szComp = size(comparisons,1);
    pPairwise = zeros(szComp,1);
    
    
    % Only check user-inputted pairwise comparisons for significance
    for w = 1:szComp
        % find [1 1] vector -- where c row and comparisons row are
        % equal
        idx = find(sum((c(:,1:2) == comparisons(w,:)),2) == 2);
        pPairwise(w) = c(idx,6);
    end

    % STYLISHLY add stats to current plot using ritzStar
    newY = ritzStar(comparisons,pPairwise,4);
    
end

ylim([0 newY+newY/10])
hold off

