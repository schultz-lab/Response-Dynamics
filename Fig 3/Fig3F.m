%% Color
col=[0.8500 0.3250 0.0980];

%% Load chemostat and CFU data
fname = 'data.xlsx';
comp = readtable(fname,'Sheet','Comp1000');
cfu_comp = readtable(fname,'Sheet','CFU1000comp');

time = table2array(comp(:,4));
OD_comp = table2array(comp(:,3));
flu_comp = table2array(comp(:,2));
back_comp = 0.016;
flu_comp = flu_comp-back_comp;
drugAdd = 15.69;
t_comp = time-drugAdd;

% Plate info
tPlates = table2array(cfu_comp(:,2));
CFUsDat = zeros(size(cfu_comp,1),3);
CFUs = zeros(size(cfu_comp,1),1);
for c = 1:size(cfu_comp,1)
    CFUsDat(c,:) = [table2array(cfu_comp(c,3:5))];
    CFUs(c) = mean(CFUsDat(c,:),"omitnan");
end

errCFU = zeros(size(CFUsDat,1),1);

for p = 1:size(CFUsDat,1)
    errCFU(p) = std(CFUsDat(p,:));
end

%% Use flu/OD from SC to find OD in comp, at each time point
% OD_SC/flu_SC * flu_comp(t) = OD_comp(t)

odPerFlu = standCurve(fname);

% Use standard curve OD/flu to convert mKO flu comp reading to KOmexZ OD
compConv = smoothdata(odPerFlu * flu_comp,'movmean',[3 3]);

%% Plot relative abundance (OD and CFUs)
figure
hold on;

ylim([0.3 1])
xlim([-5 25.3])

y = ylim;
x = xlim;

p1 = plot([0 0],[y(1) y(2)],'--k','LineWidth',4);
p2 = plot([x(1) x(2)],[0.5 0.5],'--k','LineWidth',4);

ratio = smoothdata(compConv./OD_comp,'movmean',[3 3]);

rel = plot(t_comp,ratio,'LineWidth',8,'Color',col);
scError = errorbar(tPlates,CFUs,errCFU,'LineStyle','none','Color','black','LineWidth', 3,'CapSize',14);
sc2 = scatter(tPlates,CFUs,750,col,'filled','MarkerEdgeColor','black','LineWidth',3);

set(gca,'FontSize',15,'XTick',[0 5 10 15 20 30 40],'YTick',[0.2 0.4 0.6 0.8 1])
ylabel('Δ{\itmexZ} relative abundance','FontSize',20)
xlabel('Time (hours)','FontSize',20)
l=legend([rel,sc2],'OD','CFU','Location','SE');
l.FontSize=20;

hold off;

set(findall(gcf,'-property','FontSize'),'FontSize',32)
