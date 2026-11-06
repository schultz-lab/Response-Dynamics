function plotResist(N,N2)
col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];
col(3,:)=[0.9290 0.6940 0.1250];
%%
figure
maxG = N(:,1);
dynR = N(:,2);
ssR = N(:,3);

maxG_koz = maxG(7:end);
maxG_wt = maxG(4:6);
maxG_koy = maxG(1:3);

dynR_koz = dynR(7:end);
dynR_wt = dynR(4:6);
dynR_koy = dynR(1:3);

ssR_koz = ssR(7:end);
ssR_wt = ssR(4:6);
ssR_koy = ssR(1:3);

x = N2(:,2);
y = N2(:,3);
% x = [mean(dynR_koy) mean(dynR_wt) mean(dynR_koz)];
% y = [mean(ssR_koy) mean(ssR_wt) mean(ssR_koz)];
xneg = [std(ssR_koy) std(ssR_wt) std(ssR_koz)];
yneg = [std(dynR_koy) std(dynR_wt) std(dynR_koz)];
xpos = xneg;
ypos = yneg;

hold on
numValues = 3;

% Plot data
colorDat = {[1 0.75 0] [0 0 0.61] [0.8 0.33 0]};
for k = 1 : numValues
    errorbar(y(k),x(k),yneg(k),ypos(k),xneg(k),xpos(k),'o','Color','black','LineWidth', 2);
    if k == 1
        sc3 = scatter(y(k), x(k), 400, col(3,:),'filled','MarkerEdgeColor','black');
    elseif k == 2
        sc1 = scatter(y(k), x(k), 400, col(1,:),'filled','MarkerEdgeColor','black');
    else
        sc2 = scatter(y(k), x(k), 400, col(2,:),'filled','MarkerEdgeColor','black');
    end
end

grid on;
plot([0 2500],[0 2500],':k','LineWidth',0.5)

set(gca,'FontSize',15)
xlabel('Steady-state resistance (spec. μg/mL)','FontSize',20)
ylabel('Dynamical resistance (spec. μg/mL)','FontSize',20)
ylim([0 2500])
xlim([0 2500])
l=legend([sc1,sc2,sc3],'WT','Δ{\itmexZ}','Δ{\itmexY}','Threshold','Location','best','AutoUpdate','off');
l.FontSize=20;

set(findall(gcf,'-property','FontSize'),'FontSize',30)
hold off

%% stats on graph

datNames = ["KOmexY" "WT" "KOmexZ"];
statsDat = [dynR [1;1;1;2;2;2;3;3;3]];

% ANOVA and multiple comparison correction
[p,~,stats] = anova1(statsDat(:,1),statsDat(:,2),'off');
c = multcompare(stats,'Display','off','CriticalValueType','dunn-sidak');

% STYLISHLY add stats for SS resistance to current plot
% ritzStar([p-values for each pairwise comparison], [starting y-value in which to add stats annotations],[average resistance],[stats comparison 1],[stats comparison 2])
ritzStarY(c(:,end),400,x,c(:,1),c(:,2));

statsDat = [ssR [1;1;1;2;2;2;3;3;3]];

% ANOVA and multiple comparison correction
[p,~,stats] = anova1(statsDat(:,1),statsDat(:,2),'off');
c = multcompare(stats,'Display','off','CriticalValueType','dunn-sidak');

% STYLISHLY add stats for dynamical resistance to current plot
ritzStarX(c(:,end),1500,y,c(:,1),c(:,2));

end










