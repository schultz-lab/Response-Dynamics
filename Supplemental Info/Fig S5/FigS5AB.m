%% get excel table komexZ

fname = 'data.xlsx';
col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];

%% read table 
dat_z = readtable(fname,'Sheet','KOmexZ_mono'); 

time_z = table2array(dat_z(:,4));
OD_z = table2array(dat_z(:,3));
flu_z = table2array(dat_z(:,2));

%% read table 

dat_wt = readtable(fname,'Sheet','WT_mono'); 

time_wt = table2array(dat_wt(:,4));
OD_wt = table2array(dat_wt(:,3));
flu_wt = table2array(dat_wt(:,2));


%% mko v OD for both monos (large axes)
figure(33)
endFrame = 12*60/5;
begFrame = 1;
backWT = min(flu_wt)+0.0002;
backZ = min(flu_z)+0.0002;
normFlu = 1000;
grid on;
p1w = plot(OD_wt(begFrame:endFrame),(flu_wt(begFrame:endFrame)-backWT)*normFlu,'LineWidth',24,'Color',col(1,:));
hold on

p1 = plot(OD_z(begFrame:endFrame),(flu_z(begFrame:endFrame)-backZ)*normFlu,'LineWidth',24,'Color',col(2,:));
p4 = plot([-1 1],[0 0],'--k','LineWidth',6);
xlabel('OD')
ylabel('mKO (norm.)')


%large
ylim([-2,25])
xlim([0 0.5])
yticks([0 10 20])
xticks([0 0.2 0.4])

set(findall(gcf,'-property','FontSize'),'FontSize',44)
grid off


%% OD vs time
figure(32)

p1w = plot(time_wt-2,OD_wt,'LineWidth',24,'Color',col(1,:));
hold on
p1z = plot(time_z-2.6,OD_z,'LineWidth',24,'Color',col(2,:));

ylim([0 1])
xlim([0 20])

xlabel('Time (hrs)')
ylabel('OD')

ylim([0,0.9])
xlim([0 15])
yticks([0 0.4 0.8])
xticks([0 5 10 15])

l = legend('WT','Δ{\itmexZ}','Location','northwest');

set(findall(gcf,'-property','FontSize'),'FontSize',44)

%% Get slope of KOmexZ flu/OD from 0.05 OD to ~0.4 OD. Use this value as conversion factor for chemostat competitions
figure(33)

x=OD_z;
y=(flu_z-backZ)*normFlu;

% straight part of mKO vs OD curve
idx1 = find(x > 0.05,1);
idx2 = find(x > 0.42,1);

xx = x(idx1:idx2);
yy = y(idx1:idx2);

fitSlope = polyfit(xx,yy,1);
f = polyval(fitSlope,xx);

% plot fit line then data
sc = scatter(xx,yy,1200,col(2,:),'filled','MarkerEdgeColor','black','LineWidth',6);
hold on
p = plot(xx,f,'LineWidth',12,'Color','black');


xlabel('OD')
ylabel('mKO')

set(findall(gcf,'-property','FontSize'),'FontSize',44)

hold off

