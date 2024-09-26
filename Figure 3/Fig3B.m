%% colors
col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];
col(3,:)=[0.9290 0.6940 0.1250];

%% get excel table wt

fname ='data.xlsx';
dat_wt = readtable(fname,'Sheet','WT700'); 
cfu_wt = readtable(fname,'Sheet','CFU700_WT');

time_wt = table2array(dat_wt(:,4));
OD_wt = log2(table2array(dat_wt(:,3)));
flu_wt = table2array(dat_wt(:,2));
drugAdd_wt = 24.22;
time_wt = time_wt-drugAdd_wt;

% Plate info
tPlatesWT = table2array(cfu_wt(:,2));
CFUsDatWT = zeros(size(cfu_wt,1),3);
CFUsWT = zeros(size(cfu_wt,1),1);
for c = 1:size(cfu_wt,1)
    CFUsDatWT(c,:) = [table2array(cfu_wt(c,3:5))];
    CFUsDatWT(c,:)=log2(CFUsDatWT(c,:));
    CFUsWT(c) = mean(CFUsDatWT(c,:),"omitnan");
end

errWT = zeros(size(CFUsDatWT,1),1);

for p = 1:size(CFUsDatWT,1)
    errWT(p) = std(CFUsDatWT(p,:));
end

%% get excel table KOz

dat_z = readtable(fname,'Sheet','KOmexZ700'); 
cfu_z = readtable(fname,'Sheet','CFU700_KOmexZ');

time_z = table2array(dat_z(:,4));
OD_z = log2(table2array(dat_z(:,3)));
flu_z = table2array(dat_z(:,2));
drugAdd_z = 24.13;
time_z = time_z - drugAdd_z;

% Plate info
tPlatesZ = table2array(cfu_z(:,2));
CFUsDatZ = zeros(size(cfu_z,1),3);
CFUsZ = zeros(size(cfu_z,1),1);
for c = 1:size(cfu_z,1)
    CFUsDatZ(c,:) = [table2array(cfu_z(c,3:5))];
    CFUsDatZ(c,:)=log2(CFUsDatZ(c,:));
    CFUsZ(c) = mean(CFUsDatZ(c,:),"omitnan");
end

errZ = zeros(size(CFUsDatZ,1),1);

for p = 1:size(CFUsDatZ,1)
    
    errZ(p) = std(CFUsDatZ(p,:));
    
end

%% get excel table KOy

dat_y = readtable(fname,'Sheet','KOmexY700'); 
cfu_y = readtable(fname,'Sheet','CFU700_KOmexY');

time_y = table2array(dat_y(:,4));
OD_y = log2(table2array(dat_y(:,3)));
flu_y = table2array(dat_y(:,2));
drugAdd_y = 18.15;
time_y = time_y - drugAdd_y;

% Plate info
tPlatesY = table2array(cfu_y(:,2));
CFUsDatY = zeros(size(cfu_y,1),3);
CFUsY = zeros(size(cfu_y,1),1);
for c = 1:size(cfu_y,1)
    CFUsDatY(c,:) = [table2array(cfu_y(c,3:5))];
    CFUsDatY(c,:)=log2(CFUsDatY(c,:));
    CFUsY(c) = mean(CFUsDatY(c,:),"omitnan");
end

errY = zeros(size(CFUsDatY,1),1);

for p = 1:size(CFUsDatY,1)
    errY(p) = std(CFUsDatY(p,:));
end

%% Plot

xLimHigh = 25.3;

figure(16)

% OD vs time (left y-axis)
p1w = plot(time_wt,OD_wt,'LineWidth',8,'Color',col(1,:));
hold on
p1z = plot(time_z,OD_z,'LineWidth',8,'Color',col(2,:));
p1y = plot(time_y,OD_y,'LineWidth',8,'Color',col(3,:));

yyaxis right

% Scatter plot of plate data (right y-axis)
scErrorY = errorbar(tPlatesY,CFUsY,errY,'LineStyle','none','Color','black','LineWidth', 3,'CapSize',14);
scY = scatter(tPlatesY,CFUsY,750,col(3,:),'filled','MarkerEdgeColor','black','LineWidth',3);

scErrorZ = errorbar(tPlatesZ,CFUsZ,errZ,'LineStyle','none','Color','black','LineWidth', 3,'CapSize',14);
scZ = scatter(tPlatesZ,CFUsZ,750,col(2,:),'filled','MarkerEdgeColor','black','LineWidth',3);

scErrorWT = errorbar(tPlatesWT,CFUsWT,errWT,'LineStyle','none','Color','black','LineWidth', 3,'CapSize',14);
scWT = scatter(tPlatesWT,CFUsWT,750,col(1,:),'filled','MarkerEdgeColor','black','LineWidth',3);


set(0, 'DefaultFigureRenderer', 'painters');
set(gca,'FontSize',15,'box','off','YColor','k')
ylabel(['log_{2}(CFU/ml)'],'FontSize',20)

ylim([23.7,30])
set(gca,'Ytick',[24 27 30])

yyaxis left

t_plot = time_z;

% Decay fct
dilR = 0.15*60/15;
idxFind = zeros(size(t_plot));

for ii = 1:length(t_plot)
         idxFind(ii) = abs(t_plot(ii) - 0);
end
idx = find(idxFind == min(idxFind));

maxDecay = 0.41;

timeDecay = (0:10/60:xLimHigh);

ylabel('log_{2}(OD)','FontSize',20)
xlabel('Time (hours)','FontSize',20)

yyd = log2(maxDecay*exp(-dilR.*timeDecay));
p3 = plot(timeDecay,yyd,'k','LineWidth',4);

set(gca,'Ytick',[-4 -3 -2 -1])
set(gca,'Xtick',[0 12 24])
ylim([-4.8,-0.6])
xlim([-5,xLimHigh])
y = ylim;
x = xlim;

p4 = plot([0 0],[-10 2],'--k','LineWidth',4);

l=legend([p1w,p1z,p1y,p3],'WT','Δ{\itmexZ}','Δ{\itmexY}','Dilution','Location','southwest');
l.FontSize=20;

set(findall(gcf,'-property','FontSize'),'FontSize',32)

