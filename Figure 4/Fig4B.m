%% Data input
load data

%%
col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];
col(3,:)=[0.9290 0.6940 0.1250];

% time drug was added; time relative to t=t_drug
i1=find(t>=t_drug,1)+1;
t=t-t_drug;

% correction for condensation after drug is added
d(i1,:,:)=[];
d(i1,:,:)=[];
t(i1)=[];
t(i1)=[];

%% Plot drug at ~1600 spec (8th)
j=8;
figure(1)
% WT, KOy, KOz, respectively
for i = [5 2 8]
    % Load 3 replicates
    v1 = log2(d(:,j,i));
    v2 = log2(d(:,j,i-1));
    v3 = log2(d(:,j,i+1));

    vv = log2(mean(squeeze(d(:,1,i-1:i+1))'));
    vv = vv-vv(i1);

    % Find confidence interval for each pt, assuming normal
    sigma = zeros(size(v1,1),1);
    v = zeros(size(v1,1),1);
    for k = 1:size(v1,1)
        slice = [v1(k);v2(k);v3(k)];
        distHold = fitdist(slice,'normal');
        sigma(k) = distHold.sigma;
        v(k) = distHold.mu;
    end

    confInt = [v+sigma v-sigma];
    xconf = [t fliplr(t)];         
    yconf = [confInt(:,1)' fliplr(confInt(:,2)')];

    % For plotting: Y relative to doublings at t=t_drug

    yconf = yconf-v(1);
    v=v-v(1);

    yconf = yconf-v(i1);
    v=v-v(i1);
    
    % plot via if statements for sake of legend entries
    if i == 5
        p = fill(xconf,yconf,col(1,:),'FaceColor',col(1,:),'EdgeColor','black','FaceAlpha',0.5);
        hold on
        p1 = plot(t,v,'Color',col(1,:),'LineWidth',6);
        plot(t,vv,'--','Color',col(1,:),'LineWidth',6);
    elseif i == 2
        p = fill(xconf,yconf,col(3,:),'FaceColor',col(3,:),'EdgeColor','black','FaceAlpha',0.5);
        p3 = plot(t,v,'Color',col(3,:),'LineWidth',6);
        plot(t,vv,'--','Color',col(3,:),'LineWidth',6);
    else
        p = fill(xconf,yconf,col(2,:),'FaceColor',col(2,:),'EdgeColor','black','FaceAlpha',0.3);
        p2 = plot(t,v,'Color',col(2,:),'LineWidth',6);
        plot(t,vv,'--','Color',col(2,:),'LineWidth',6);
        p4 = plot([0 0],[-1 2],'--k','LineWidth',3);
        plot([-2 30],[1 1],':k','LineWidth',1);
    end

    ylim([-0.3 3.2])
    xlim([-2 34])

end

set(gca,'FontSize',15,'XTick',[0 10 20 30],'YTick',[0 1 2 3],'box','off')
ylabel('Growth (doublings)','FontSize',20)
xlabel('Time (hrs)','FontSize',20)

l=legend([p1,p2,p3],'WT','Δ{\itmexZ}','Δ{\itmexY}','Location','northwest');
l.FontSize=20;

set(findall(gcf,'-property','FontSize'),'FontSize',30)
