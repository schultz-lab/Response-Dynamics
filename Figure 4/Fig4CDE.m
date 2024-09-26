%% Data input
load data

%% Growth rate and delay after drug addition

M = growthanddelay(data);

%% SS (4C) and dyn resistance (4D) plots

[N,vx,vy,drug,drug_range,threshD] = resistances(M);

%% Find confidence interval for each pt on line graph for 3 replicates, assuming normal
sigmaX = zeros(size(vx,2),3);
sigmaY = zeros(size(vy,2),3);

num=0;
for i = [1 4 7]
    num = num+1;
    for k = 1:size(vx,2)
        sliceX = [vx(i,k);vx(i+1,k);vx(i+2,k)];
        sliceY = [vy(i,k);vy(i+1,k);vy(i+2,k)];
        
        if ~isnan(sliceX(1))
            distHoldX = fitdist(sliceX,'normal');
            passX = 1;
        else
            passX = 0;
        end
        if ~isnan(sliceY(1))
            distHoldY = fitdist(sliceY,'normal');
            passY = 1;
        else
            passY = 0;
        end
        
        if passX == 1
            sigmaX(k,num) = distHoldX.sigma;
        else
            sigmaX(k,num) = NaN;
        end
        
        if passY == 1
            sigmaY(k,num) = distHoldY.sigma;
        else
            sigmaY(k,num) = NaN;
        end
    end
end

%% Find std of each point on scatterplot

% delay error
err = zeros(size(M,1),3,2);
avg = zeros(size(M,1),3,2);

num=0;
for c = [1 4 7]
    num = num+1;
    for p = 1:size(M,1)
        err(p,num,1) = std([M(p,c,1);M(p,c+1,1);M(p,c+2,1)]);
        avg(p,num,1) = mean([M(p,c,1);M(p,c+1,1);M(p,c+2,1)]);

        err(p,num,2) = std([M(p,c,2);M(p,c+1,2);M(p,c+2,2)]);
        avg(p,num,2) = mean([M(p,c,2);M(p,c+1,2);M(p,c+2,2)]);
    end  
end

%% Plot for dyn resist (4C): avg lineplot, scatterplot, error of scatter

col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];
col(3,:)=[0.9290 0.6940 0.1250];

figure(15)

% put first drug conc near 0 on x-axis
drug(1)=2.31;

hold on
idx = find(drug_range>drug(2),1)-1;
% Plot line
p3 = plot(10.^drug_range(idx:end),mean(vx(1:3,idx:end)),'Color',col(3,:),'LineWidth',6);
p1 = plot(10.^drug_range(idx:end),mean(vx(4:6,idx:end)),'Color',col(1,:),'LineWidth',6);
p2 = plot(10.^drug_range(idx:end),mean(vx(7:9,idx:end)),'Color',col(2,:),'LineWidth',6);

% Error scatter
es3 = errorbar(10.^drug,avg(:,1,1),err(:,1,1),'LineStyle','none','Color','black','LineWidth', 2,'CapSize',14);
es1 = errorbar(10.^drug,avg(:,2,1),err(:,2,1),'LineStyle','none','Color','black','LineWidth', 2,'CapSize',14);
es2 = errorbar(10.^drug,avg(:,3,1),err(:,3,1),'LineStyle','none','Color','black','LineWidth', 2,'CapSize',14);

% Avg scatter
s3 = scatter(10.^drug,avg(:,1,1),250,col(3,:),'filled','MarkerEdgeColor','black','LineWidth',3);
s1 = scatter(10.^drug,avg(:,2,1),250,col(1,:),'filled','MarkerEdgeColor','black','LineWidth',3);
s2 = scatter(10.^drug,avg(:,3,1),250,col(2,:),'filled','MarkerEdgeColor','black','LineWidth',3);

% Plot threshold
thresh = plot([1 3000],[threshD threshD],'--k');

set(0, 'DefaultFigureRenderer', 'painters');
set(gca,'XScale','log','FontSize',15,'XTick',[300 1000 3000],'YTick',[0 2 5 10 15])
axis([200 3000 0 15])
xlabel('Spectinomycin (\mug/ml)','FontSize',20)
ylabel('Delay (hours)','FontSize',20)
l=legend([p1,p2,p3],'WT','Δ{\itmexZ}','Δ{\itmexY}','Location','best');
l.FontSize=20;
set(findall(gcf,'-property','FontSize'),'FontSize',30)
hold off

%% Plot for SS resist (4D): avg lineplot, scatterplot, error of scatter

figure(16)
hold on
% Plot line
p3 = plot(10.^drug_range(idx:end),mean(vy(1:3,idx:end)),'Color',col(3,:),'LineWidth',6);
p1 = plot(10.^drug_range(idx:end),mean(vy(4:6,idx:end)),'Color',col(1,:),'LineWidth',6);
p2 = plot(10.^drug_range(idx:end),mean(vy(7:9,idx:end)),'Color',col(2,:),'LineWidth',6);

% Error scatter
es3 = errorbar(10.^drug,avg(:,1,2),err(:,1,2),'LineStyle','none','Color','black','LineWidth', 2,'CapSize',14);
es1 = errorbar(10.^drug,avg(:,2,2),err(:,2,2),'LineStyle','none','Color','black','LineWidth', 2,'CapSize',14);
es2 = errorbar(10.^drug,avg(:,3,2),err(:,3,2),'LineStyle','none','Color','black','LineWidth', 2,'CapSize',14);

% Avg scatter
s3 = scatter(10.^drug,avg(:,1,2),250,col(3,:),'filled','MarkerEdgeColor','black','LineWidth',3);
s1 = scatter(10.^drug,avg(:,2,2),250,col(1,:),'filled','MarkerEdgeColor','black','LineWidth',3);
s2 = scatter(10.^drug,avg(:,3,2),250,col(2,:),'filled','MarkerEdgeColor','black','LineWidth',3);

% Plot threshold
threshS = mean(M(1,:,2))/2;
thresh = plot([1 10000],[threshS threshS],'--k');

set(0, 'DefaultFigureRenderer', 'painters');
set(gca,'XScale','log','FontSize',15,'XTick',[300 1000 3000],'YTick',[0 0.1 0.2 0.3])
axis([200 3000 0 0.3])
xlabel('Spectinomycin (\mug/ml)','FontSize',20)
ylabel('Growth (doub/h)','FontSize',20)
l=legend([p1,p2,p3],'WT','Δ{\itmexZ}','Δ{\itmexY}','Location','best');
l.FontSize=20;
set(findall(gcf,'-property','FontSize'),'FontSize',30)
hold off

%% Fig 4E
plotResist(N)


