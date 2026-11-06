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
figure
% WT, KOy, KOz, respectively
for i = [5 2 8]
    % Load 3 replicates
    v = log2(mean(squeeze(d(:,j,i-1:i+1))'));

    v=v-v(i1);
    [c,i4]=findfit(v,i1,t);
    
    % plot via if statements for sake of legend entries
    if i == 5
        hold on
        p1 = plot(t,v,'Color',col(1,:),'LineWidth',6);
        plot(t(i1:i4),polyval(c,t(i1:i4)),'--','Color',col(1,:),'LineWidth',3)
        polyval(c,t(i1))
        
    elseif i == 2
        p3 = plot(t,v,'Color',col(3,:),'LineWidth',6);
        plot(t(i1:i4),polyval(c,t(i1:i4)),'--','Color',col(3,:),'LineWidth',3)
        polyval(c,t(i1))
        
    else
        p2 = plot(t,v,'Color',col(2,:),'LineWidth',6);
        plot(t(i1:i4),polyval(c,t(i1:i4)),'--','Color',col(2,:),'LineWidth',3)
        polyval(c,t(i1))
        
    end

end

plot([0 0],[-1 2],'--k','LineWidth',3);
plot([-2 30],[1 1],':k','LineWidth',1);

ylim([-1.3 3.2])
xlim([-2 34])

set(gca,'FontSize',15,'XTick',[0 10 20 30],'YTick',[0 1 2 3],'box','off')
ylabel('Growth (doublings)','FontSize',20)
xlabel('Time (hrs)','FontSize',20)

l=legend([p1,p2,p3],'WT','Δ{\itmexZ}','Δ{\itmexY}','Location','northwest');
l.FontSize=20;

set(findall(gcf,'-property','FontSize'),'FontSize',30)



function [c,i4]=findfit(v,i1,t)

    o1=v(i1); %log OD at time drug added        
    o2=o1+1; %log OD at time drug added


    %row at which log OD is 1 doubling from drug added OD
    i2=find(v(i1:end)>o2,1);
    i2=i2+i1-1;

    o3=o2;
    mm=max(v);
    o4=max(o3+0.5,mm-0.2);

    i3=find(v(i2:end)>o3,1);
    i3=i3+i2-1;
    
    i4=find(v(i3:end)>=o4,1);

    if(~isempty(i4))
        i4=i4+i3-1;
    else
        i4=length(v);
    end

    c=polyfit(t(i3:i4),v(i3:i4),1);

end
