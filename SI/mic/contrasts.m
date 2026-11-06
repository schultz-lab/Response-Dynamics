M=readmatrix('pics_binary.csv','Range',[2 2]);

cmex=M(:,1);
cic50=M(:,2);
cmic=M(:,3);

figure

subplot(1,2,1)

b1=cmex\cic50;
cic50x=b1*cmex;
Rsq1 = 1 - sum((cic50 - cic50x).^2)/sum((cic50 - mean(cic50)).^2);

[c1 p1]=corr(cmex,cic50);

v=[min(cmex) max(cmex)];
plot(v,b1*v,'LineWidth',3)
hold on
scatter(cmex,cic50,100,'filled')
set(gca,'FontSize',15,'Box','off');%,'XTick',[-42.1 [-30:10:20]],'YTick',[-20:10:20])
xlabel('Contrasts {\it mexZ}','FontSize',20)
ylabel('Contrasts IC_{50}','FontSize',20)
text(-1.25,8000,['R^2 = ' num2str(Rsq1,'%.3f')],'FontSize',20)
text(-1.25,7000,['r = ' num2str(c1,'%.2f')],'FontSize',20)
text(-1.25,6000,['p = ' num2str(p1,'%.2f')],'FontSize',20)


subplot(1,2,2)

b1=cmex\cmic;
cmicx=b1*cmex;
Rsq1 = 1 - sum((cmic - cmicx).^2)/sum((cmic - mean(cmic)).^2);

[c1 p1]=corr(cmex,cmic);

v=[min(cmex) max(cmex)];
plot(v,b1*v,'LineWidth',3)
hold on
scatter(cmex,cmic,100,'filled')
set(gca,'FontSize',15,'Box','off');%,'XTick',[-42.1 [-30:10:20]],'YTick',[-20:10:20])
xlabel('Contrasts {\it mexZ}','FontSize',20)
ylabel('Contrasts MIC','FontSize',20)
text(-1.25,6000,['R^2 = ' num2str(Rsq1,'%.3f')],'FontSize',20)
text(-1.25,5000,['r = ' num2str(c1,'%.2f')],'FontSize',20)
text(-1.25,4000,['p = ' num2str(p1,'%.2f')],'FontSize',20)

