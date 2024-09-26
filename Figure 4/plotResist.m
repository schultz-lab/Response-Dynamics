function plotResist(N)
col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];
col(3,:)=[0.9290 0.6940 0.1250];
%%
figure(4)
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

x = [mean(dynR_koy) mean(dynR_wt) mean(dynR_koz)];
y = [mean(ssR_koy) mean(ssR_wt) mean(ssR_koz)];
xneg = [std(dynR_koy) std(dynR_wt) std(dynR_koz)];
xpos = xneg;
yneg = [std(ssR_koy) std(ssR_wt) std(ssR_koz)];
ypos = yneg;

hold on
numValues = 3;

% Plot data
colorDat = {[1 0.75 0] [0 0 0.61] [0.8 0.33 0]};
for k = 1 : numValues
    errorbar(x(k),y(k),yneg(k),ypos(k),xneg(k),xpos(k),'o','Color','black','LineWidth', 2);
    if k == 1
        sc3 = scatter(x(k), y(k), 400, col(3,:),'filled','MarkerEdgeColor','black');
    elseif k == 2
        sc1 = scatter(x(k), y(k), 400, col(1,:),'filled','MarkerEdgeColor','black');
    else
        sc2 = scatter(x(k), y(k), 400, col(2,:),'filled','MarkerEdgeColor','black');
    end
end

grid on;

set(gca,'FontSize',15)
ylabel('Steady-state resistance (spec. μg/mL)','FontSize',20)
xlabel('Dynamical resistance (spec. μg/mL)','FontSize',20)
xlim([0 2000])
ylim([0 2500])
l=legend([sc1,sc2,sc3],'WT','Δ{\itmexZ}','Δ{\itmexY}','Threshold','Location','best');
l.FontSize=20;

set(findall(gcf,'-property','FontSize'),'FontSize',30)
hold off

%% t-test

%[hS,pS] = ttest2(ssR_wt,ssR_mut,'Tail','both','Alpha',0.05);

%[hD,pD] = ttest2(dynR_wt,dynR_mut,'Tail','both','Alpha',0.05);
end










