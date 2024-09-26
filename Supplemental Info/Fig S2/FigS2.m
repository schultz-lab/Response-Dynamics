load data

%% pre-drug WT mexXY vs many things
col = [0 0.4470 0.7410;0.8500 0.3250 0.0980;0.4940 0.1840 0.5560;0.4660 0.6740 0.1880];

accuGrowth = max(a(1,:,:),[],3)-a(1,:,59);
div = sum(d(1,:,70:end),3,"omitnan");
lens = squeeze(blobsGlobal(:,3,:));
lenAtDrug = mean(lens(:,57:59),2);


% convert any cells not growing at end to zero growth rate.. try two
% different averaging techniques
growthRateLen1 = mean(g(1,:,204-30:204),3);
growthRateLen1(isnan(growthRateLen1))=0;

growthRateLen2 = mean(g(1,:,204-1:204),3);
growthRateLen2(isnan(growthRateLen2))=0;

gr = zeros(2,36);
gr(1,:) = growthRateLen1;
gr(2,:) = growthRateLen2;

% begin grow
growthRateBeg = mean(g(1,:,59-20:59),3,"omitnan");

% basal mexXY
basalMexxy1 = mean(m(1,:,1:59),3,"omitnan");
basalMexxy2 = mean(m(1,:,20:59),3,"omitnan");

bas = zeros(2,36);
bas(1,:) = basalMexxy1;
bas(2,:) = basalMexxy2;

val = 24;
for BAS = 1
    b = bas(BAS,:);
    for GROW = 1
        gro = gr(GROW,:);
        figure
        % basal mexXY vs accu growth after drug
        subplot(2,2,1)
        hold on
        y=accuGrowth;
        x=b;
        scatter(x,y,450,col(1,:),'filled','MarkerEdgeColor','black','LineWidth',3);
        xlabel('Pre-drug MexXY expr. (norm.)')
        ylabel('Final growth (doub.)')
        %axis([0 213 0 1200])
        r = corrcoef(x,y);
        r=string(round(r(2),2));
        out1 = strcat("{\itr} = ",r);
        axis([0.5 1.6 -0.4 5.6])

        set(findall(gcf,'-property','FontSize'),'FontSize',val)
        

        subplot(2,2,2)
        y=div;
        scatter(x,y,450,col(2,:),'filled','MarkerEdgeColor','black','LineWidth',3);
        xlabel('Pre-drug MexXY expr. (norm.)')
        ylabel('Divisions after drug')
        r = corrcoef(x,y);
        r=string(round(r(2),2));
        out2 = strcat("{\itr} = ",r);
        
        axis([0.5 1.6 -0.2 5.2])
        yticks(0:5)
        set(findall(gcf,'-property','FontSize'),'FontSize',val)
        

        subplot(2,2,3)
        y=gro;
        scatter(x,y,450,col(3,:),'filled','MarkerEdgeColor','black','LineWidth',3);
        xlabel('Pre-drug MexXY expr. (norm.)')
        ylabel('Final growth (doub./h)')
        r = corrcoef(x,y);
        r=string(round(r(2),2));
        out3 = strcat("{\itr} = ",r);
        
        axis([0.5 1.6 -0.2 0.8])
        set(findall(gcf,'-property','FontSize'),'FontSize',val)
        

        subplot(2,2,4)
        x=growthRateBeg;
        y=gro;
        scatter(x,y,450,col(4,:),'filled','MarkerEdgeColor','black','LineWidth',3);
        xlabel('Growth before drug (doub./h)')
        ylabel('Final growth (doub./h)')
        r = corrcoef(x,y);
        r=string(round(r(2),2));
        out = strcat("{\itr} = ",r);
        
        axis([-0.5 1.5 -0.5 1.5])
        set(findall(gcf,'-property','FontSize'),'FontSize',val)
        text(0,0.8,out,'FontSize',32)

        subplot(2,2,1)
        text(1.27,3,out1,'FontSize',32)
        
        subplot(2,2,2)
        text(1.27,2,out2,'FontSize',32)
        
        subplot(2,2,3)
        text(1.27,0.3,out3,'FontSize',32)
        
        
    end
end
%% max mexxy vs many things
col = ["r";"g";"b";"m"];
maxMexxy = max(m(1,:,70:end),[],3);

figure
subplot(2,2,1)
hold on
y=accuGrowth;
x=maxMexxy;
scatter(x,y,450,col(1),'filled','MarkerEdgeColor','black','LineWidth',3);
xlabel('Max MexXY expr. (norm.)')
ylabel('Final growth (doub.)')
r = corrcoef(x,y);
r=string(round(r(2),2));
out1 = strcat("{\itr} = ",r);
axis([0 6 0 5.6])

set(findall(gcf,'-property','FontSize'),'FontSize',val)


subplot(2,2,2)
y=div;
scatter(x,y,450,col(2),'filled','MarkerEdgeColor','black','LineWidth',3);
xlabel('Max MexXY expr. (norm.)')
ylabel('Divisions after drug')
r = corrcoef(x,y);
r=string(round(r(2),2));
out2 = strcat("{\itr} = ",r);

axis([0 6 -0.2 5.2])
yticks(0:5)
set(findall(gcf,'-property','FontSize'),'FontSize',val)


subplot(2,2,3)
y=growthRateLen1;
scatter(x,y,450,col(3),'filled','MarkerEdgeColor','black','LineWidth',3);
xlabel('Max MexXY expr. (norm.)')
ylabel('Final growth (doub./h)')
r = corrcoef(x,y);
r=string(round(r(2),2));
out3 = strcat("{\itr} = ",r);

axis([0 6 -0.2 0.8])
set(findall(gcf,'-property','FontSize'),'FontSize',val)


subplot(2,2,4)
y=x;
x=growthRateBeg;
scatter(x,y,450,col(4),'filled','MarkerEdgeColor','black','LineWidth',3);
xlabel('Growth before drug (doub./h)')
ylabel('Max MexXY expr. (norm.)')
r = corrcoef(x,y);
r=string(round(r(2),2));
out = strcat("{\itr} = ",r);

axis([0.4 1.5 0 6])
set(findall(gcf,'-property','FontSize'),'FontSize',val)
text(0.5,4,out,'FontSize',32)

subplot(2,2,1)
text(1,3.5,out1,'FontSize',32)

subplot(2,2,2)
text(1,3,out2,'FontSize',32)

subplot(2,2,3)
text(1,0.5,out3,'FontSize',32)

%% basal mexXY vs max mexXY
figure
subplot(2,2,3)
x=basalMexxy1;
y=maxMexxy;
scatter(x,y,450,"c",'filled','MarkerEdgeColor','black','LineWidth',3);
ylabel('Max MexXY expr. (norm.)')
xlabel('Pre-drug MexXY expr. (norm.)')
r = corrcoef(x,y);
r=string(round(r(2),2));
out1 = strcat("{\itr} = ",r);
axis([0.5 1.6 0 6])

set(findall(gcf,'-property','FontSize'),'FontSize',val)
text(1.2,2,out1,'FontSize',32)

%% Final growth vs cell length at drug addition
figure
subplot(2,2,1)
x=log2(lenAtDrug);
y=gr(1,:);
scatter(x,y,450,[0.6350 0.0780 0.1840],'filled','MarkerEdgeColor','black','LineWidth',3);
ylabel('Final growth (doub./hr)')
xlabel('Cell length before drug (doub.)')
r = corrcoef(x,y);
r=string(round(r(2),2));
out1 = strcat("{\itr} = ",r);
axis([0 3 -0.2 0.7])

set(findall(gcf,'-property','FontSize'),'FontSize',val)
text(2,0.2,out1,'FontSize',32)


%% Max MexXY vs cell length at drug addition
figure
subplot(2,2,3)
y=maxMexxy;
scatter(x,y,450,"yellow",'filled','MarkerEdgeColor','black','LineWidth',3);
ylabel('Max MexXY expr. (norm.)')
xlabel('Cell length before drug (doub.)')
r = corrcoef(x,y);
r=string(round(r(2),2));
out1 = strcat("{\itr} = ",r);
axis([0 3 0 6])

set(findall(gcf,'-property','FontSize'),'FontSize',val)
text(2,3,out1,'FontSize',32)

%save data t x a d g r c m

% t - time (hours)
% x - length (um)
% a - accumulated growth (doub)
% d - division events
% g - growth (doub/h)
% j - 1: no divisions, 2: 1 or 2 divisions, 3: 3 or more divisions
% r - RFP, mexXY
% c - GFP, rpoB (constitutive)
% m - normalized mexXY