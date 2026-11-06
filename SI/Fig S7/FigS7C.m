%% Load chemostat and CFU data
fname = 'data.xlsx';
comp = readtable(fname,'Sheet','Comp700');
cfu_comp = readtable(fname,'Sheet','CFU700comp');

time = table2array(comp(:,4));
OD_comp = table2array(comp(:,3));
drugAdd = 19.50;
t_comp = time-drugAdd;

% Plate info
tPlates = table2array(cfu_comp(:,2));
CFUsDat = zeros(size(cfu_comp,1),3);
CFUs = zeros(size(cfu_comp,1),1);
for c = 1:size(cfu_comp,1)
    CFUsDat(c,:) = [table2array(cfu_comp(c,6:8))];
    CFUsDat(c,:) = log2(CFUsDat(c,:));
    CFUs(c) = mean(CFUsDat(c,:),"omitnan");
end

err = zeros(size(CFUsDat,1),1);

for p = 1:size(CFUsDat,1)
    err(p) = std(CFUsDat(p,:));
end

%% Plot total OD and total CFUs

xLimHigh = 25;

figure;

% OD vs time (left y-axis)
p1 = plot(t_comp,log2(OD_comp),'LineWidth',24,'Color',[0.4940 0.1840 0.5560]);
hold on

yyaxis right

% Scatter plot of plate data (right y-axis)
scError = errorbar(tPlates,CFUs,err,'LineStyle','none','Color','black','LineWidth', 6,'CapSize',14);
sc = scatter(tPlates,CFUs,1200,[0.4940 0.1840 0.5560],'filled','MarkerEdgeColor','black','LineWidth',6);

set(0, 'DefaultFigureRenderer', 'painters');
set(gca,'FontSize',15,'box','off','YColor','k')
ylabel(['log_{2}(CFU/ml)'],'FontSize',20)

ylim([22,30])
set(gca,'Ytick',[24 27 30])

yyaxis left

% Decay fct
dilR = 0.15*60/15;
idxFind = zeros(size(t_comp));

for ii = 1:length(t_comp)
         idxFind(ii) = abs(t_comp(ii) - 0);
end
idx = find(idxFind == min(idxFind));

maxDecay = 0.35;

timeDecay = (0:10/60:xLimHigh);

ylabel('log_{2}(OD)','FontSize',20)
xlabel('Time (hours)','FontSize',20)

yyd = log2(maxDecay*exp(-dilR.*timeDecay));
p3 = plot(timeDecay,yyd,'k','LineWidth',12);

set(gca,'Ytick',[-4 -3 -2 -1])
set(gca,'Xtick',[0 12 24])
ylim([-4.8,-0.6])
xlim([-5,xLimHigh])
y = ylim;
x = xlim;

p4 = plot([0 0],[-10 2],'--k','LineWidth',6);

l=legend([p1,sc],'OD','CFUs','Location','southwest');
l.FontSize=20;

set(findall(gcf,'-property','FontSize'),'FontSize',44)
