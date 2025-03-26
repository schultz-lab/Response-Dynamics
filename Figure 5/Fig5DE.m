M=readmatrix('pics_cont.csv','Range',[2 2]);

cmex=M(:,1);
cdynres=M(:,2);
cssres=M(:,3);
cratio=M(:,4);

figure

subplot(1,2,1)

b1=cmex\cdynres;
cdynres2=b1*cmex;
Rsq1 = 1 - sum((cdynres - cdynres2).^2)/sum((cdynres - mean(cdynres)).^2);

[c1 p1]=corr(cmex,cdynres);

v=[min(cmex) max(cmex)];
plot(v,b1*v,'LineWidth',3)
hold on
scatter(cmex,cdynres,100,'filled')
set(gca,'FontSize',15,'Box','off');%,'XTick',[-42.1 [-30:10:20]],'YTick',[-20:10:20])
xlabel('Contrasts {\it mexZ}','FontSize',20)
ylabel('Contrasts Dynamical Resistance','FontSize',20)
text(-400,1800,['R^2 = ' num2str(Rsq1,'%.2f')],'FontSize',20)
text(-400,1600,['r = ' num2str(c1,'%.2f')],'FontSize',20)
text(-400,1400,['p = ' num2str(p1,'%.2f')],'FontSize',20)


subplot(1,2,2)

b2=cmex\cssres;
cssres2=b2*cmex;
Rsq2 = 1 - sum((cssres - cssres2).^2)/sum((cssres - mean(cssres)).^2);

[c2 p2]=corr(cmex,cssres);

v=[min(cmex) max(cmex)];
plot(v,b2*v,'LineWidth',3)
hold on
scatter(cmex,cssres,100,'filled')
set(gca,'FontSize',15,'Box','off');%,'XTick',[-42.1 [-30:10:20]],'YTick',[-20:10:20])
xlabel('Contrasts {\it mexZ}','FontSize',20)
ylabel('Contrasts Steady-state Resistance','FontSize',20)
text(-400,1350,['R^2 = ' num2str(Rsq2,'%.2f')],'FontSize',20)
text(-400,1150,['r = ' num2str(c2,'%.2f')],'FontSize',20)
text(-400,950,['p = ' num2str(p2,'%.2f')],'FontSize',20)

% figure
% 
% b3=cmex\cratio;
% cratio2=b3*cmex;
% Rsq3 = 1 - sum((cratio - cratio2).^2)/sum((cratio - mean(cratio)).^2);
% 
% [c3 p3]=corr(cmex,cratio);
% 
% v=[min(cmex) max(cmex)];
% plot(v,b3*v,'LineWidth',3)
% hold on
% scatter(cmex,cratio,100,'filled')
% set(gca,'FontSize',15);%,'XTick',[-42.1 [-30:10:20]],'YTick',[-20:10:20])
% xlabel('Contrasts {\it mexZ}','FontSize',20)
% ylabel('Contrasts Dyn/SS Ratio','FontSize',20)
% text(-100,3.5,['R^2 = ' num2str(Rsq3,'%.2f')],'FontSize',20)
% text(-100,3.2,['c = ' num2str(c3,'%.2f')],'FontSize',20)
% text(-100,2.9,['p = ' num2str(p3,'%.2f')],'FontSize',20)

%%%%%%%

M=readmatrix('pics_binary.csv','Range',[2 2]);

cmex=M(:,1);
cdynres=M(:,2);
cssres=M(:,3);
cratio=M(:,4);

figure

subplot(1,2,1)

b1=cmex\cdynres;
cdynres2=b1*cmex;
Rsq1 = 1 - sum((cdynres - cdynres2).^2)/sum((cdynres - mean(cdynres)).^2);

[c1 p1]=corr(cmex,cdynres);

v=[min(cmex) max(cmex)];
plot(v,b1*v,'LineWidth',3)
hold on
scatter(cmex,cdynres,100,'filled')
set(gca,'FontSize',15,'Box','off');%,'XTick',[-42.1 [-30:10:20]],'YTick',[-20:10:20])
xlabel('Contrasts {\it mexZ}','FontSize',20)
ylabel('Contrasts Dynamical Resistance','FontSize',20)
text(-0.8,1350,['R^2 = ' num2str(Rsq1,'%.2f')],'FontSize',20)
text(-0.8,1150,['r = ' num2str(c1,'%.2f')],'FontSize',20)
text(-0.8,950,['p = ' num2str(p1,'%.2f')],'FontSize',20)


subplot(1,2,2)

b2=cmex\cssres;
cssres2=b2*cmex;
Rsq2 = 1 - sum((cssres - cssres2).^2)/sum((cssres - mean(cssres)).^2);

[c2 p2]=corr(cmex,cssres);

v=[min(cmex) max(cmex)];
plot(v,b2*v,'LineWidth',3)
hold on
scatter(cmex,cssres,100,'filled')
set(gca,'FontSize',15,'Box','off');%,'XTick',[-42.1 [-30:10:20]],'YTick',[-20:10:20])
xlabel('Contrasts {\it mexZ}','FontSize',20)
ylabel('Contrasts Steady-state Resistance','FontSize',20)
text(-0.8,1350,['R^2 = ' num2str(Rsq2,'%.2f')],'FontSize',20)
text(-0.8,1150,['r = ' num2str(c2,'%.2f')],'FontSize',20)
text(-0.8,950,['p = ' num2str(p2,'%.2f')],'FontSize',20)

figure

b3=cmex\cratio;
cratio2=b3*cmex;
Rsq3 = 1 - sum((cratio - cratio2).^2)/sum((cratio - mean(cratio)).^2);

[c3 p3]=corr(cmex,cratio);

v=[min(cmex) max(cmex)];
plot(v,b3*v,'LineWidth',3)
hold on
scatter(cmex,cratio,100,'filled')
set(gca,'FontSize',15,'Box','off');%,'XTick',[-42.1 [-30:10:20]],'YTick',[-20:10:20])
xlabel('Contrasts {\it mexZ}','FontSize',20)
ylabel('Contrasts Dyn/SS Ratio','FontSize',20)
text(-0.8,1.5,['R^2 = ' num2str(Rsq3,'%.2f')],'FontSize',20)
text(-0.8,1.2,['r = ' num2str(c3,'%.2f')],'FontSize',20)
text(-0.8,0.9,['p = ' num2str(p3,'%.2f')],'FontSize',20)