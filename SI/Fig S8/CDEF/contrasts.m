M=readmatrix('pics_binary.csv','Range',[2 2]);

cmex=M(:,1);
cdynres=M(:,2);
cssres=M(:,3);
cratio=M(:,4);
cdynres1=M(:,5);
cdynres2=M(:,6);

figure

b1=cmex\cdynres;
cdynresx=b1*cmex;
Rsq1 = 1 - sum((cdynres - cdynresx).^2)/sum((cdynres - mean(cdynresx)).^2);

[c1 p1]=corr(cmex,cdynres);

v=[min(cmex) max(cmex)];
plot(v,b1*v,'LineWidth',3)
hold on
scatter(cmex,cdynres,100,'filled')
set(gca,'FontSize',15,'Box','off');%,'XTick',[-42.1 [-30:10:20]],'YTick',[-20:10:20])
xlabel('Contrasts {\it mexZ}','FontSize',20)
ylabel('Contrasts Dynamical Resistance','FontSize',20)
text(-0.7,1350,['R^2 = ' num2str(Rsq1,'%.2f')],'FontSize',20)
text(-0.7,1150,['r = ' num2str(c1,'%.2f')],'FontSize',20)
text(-0.7,950,['p = ' num2str(p1,'%.2f')],'FontSize',20)


figure

subplot(1,2,1)

b1=cmex\cdynres1;
cdynresx=b1*cmex;
Rsq1 = 1 - sum((cdynres1 - cdynresx).^2)/sum((cdynres1 - mean(cdynres1)).^2);

[c1 p1]=corr(cmex,cdynres1);

v=[min(cmex) max(cmex)];
plot(v,b1*v,'LineWidth',3)
hold on
scatter(cmex,cdynres1,100,'filled')
set(gca,'FontSize',15,'Box','off','XTick',[-1.5:0.5:1.5],'YTick',[-1000:1000:2000])
axis([-1.5 1.5 -1200 2010])
xlabel('Contrasts {\it mexZ}','FontSize',20)
ylabel('Contrasts Dynamical Resistance','FontSize',20)
text(-1,1350,['R^2 = ' num2str(Rsq1,'%.2f')],'FontSize',20)
text(-1,1150,['r = ' num2str(c1,'%.2f')],'FontSize',20)
text(-1,950,['p = ' num2str(p1,'%.2e')],'FontSize',20)


subplot(1,2,2)

b1=cmex\cdynres2;
cdynresx=b1*cmex;
Rsq1 = 1 - sum((cdynres2 - cdynresx).^2)/sum((cdynres2 - mean(cdynres2)).^2);

[c1 p1]=corr(cmex,cdynres2);

v=[min(cmex) max(cmex)];
plot(v,b1*v,'LineWidth',3)
hold on
scatter(cmex,cdynres2,100,'filled')
set(gca,'FontSize',15,'Box','off','XTick',[-1.5:0.5:1.5],'YTick',[-1000:1000:2000])
axis([-1.5 1.5 -1200 2010])
xlabel('Contrasts {\it mexZ}','FontSize',20)
ylabel('Contrasts Dynamical Resistance','FontSize',20)
text(-1,1350,['R^2 = ' num2str(Rsq1,'%.2f')],'FontSize',20)
text(-1,1150,['r = ' num2str(c1,'%.2f')],'FontSize',20)
text(-1,950,['p = ' num2str(p1,'%.2e')],'FontSize',20)

