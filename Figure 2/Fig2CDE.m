load data

col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];
col(3,:)=[0.9290 0.6940 0.1250];

% plot growth of 3 genotypes over time
figure
subplot(3,3,[1 2 3])
for i=1:36
for n=1:3
    hold on
    plot(t(n,5:end-4),squeeze(g(n,i,5:end-4)),'Color',0.7*[1 1 1]+0.3*col(n,:),'LineWidth',1)
end
end
for n=1:3
    h(n)=plot(t(n,5:end-4),squeeze(nanmean(g(n,:,5:end-4))),'Color',col(n,:),'LineWidth',3);
end
l=legend([h(1) h(2) h(3)],{'WT','\Delta{\itmexZ}','\Delta{\itmexY}'},'AutoUpdate','off');
l.FontSize=20;

plot([0 0],[-0.5 2],'--k','LineWidth',2)
plot([-4 12],[0 0],'--k','LineWidth',2)
axis([-4 12 -0.5 2])
set(gca,'FontSize',15,'XTick',[-4 0 4 8 12],'YTick',[-0.5 0 0.5 1 1.5],'box','off')
xlabel('Time (hours)','FontSize',20)
ylabel('Growth (doub./h)','FontSize',20)

% plot mexXY expr. of 3 genotypes over time
subplot(3,3,[4 5 6])
for i=1:36
for n=1:2
    hold on
    plot(t(n,5:end-4),squeeze(m(n,i,5:end-4)),'Color',0.7*[1 1 1]+0.3*col(n,:),'LineWidth',1)
end
end
for n=1:2
    plot(t(n,5:end-4),squeeze(nanmean(m(n,:,5:end-4))),'Color',col(n,:),'LineWidth',3)
end

plot([0 0],[0 2.5],'--k','LineWidth',2)
plot([-4 12],[1 1],'--k','LineWidth',2)
axis([-4 12 0 5])
set(gca,'FontSize',15,'XTick',[-4 0 4 8 12],'YTick',[0 2 4 6],'box','off')
xlabel('Time (hours)','FontSize',20)
ylabel('MexXY expr. (norm.)','FontSize',20)

% avg expr. and growth around different time points (0,4,12 hrs) for each genotype
for i=1:36
    gg(1,i,1)=nanmean(g(1,i,23:59));
    gg(1,i,2)=nanmean(g(1,i,95:119));
    gg(1,i,3)=nanmean(g(1,i,178:203));
    mm(1,i,1)=nanmean(m(1,i,23:59));
    mm(1,i,2)=nanmean(m(1,i,95:119));
    mm(1,i,3)=nanmean(m(1,i,178:203));
end
for i=1:36
    gg(2,i,1)=nanmean(g(2,i,30:66));
    gg(2,i,2)=nanmean(g(2,i,102:126));
    gg(2,i,3)=nanmean(g(2,i,185:210));
    mm(2,i,1)=nanmean(m(2,i,30:66));
    mm(2,i,2)=nanmean(m(2,i,102:126));
    mm(2,i,3)=nanmean(m(2,i,185:210));
end
for i=1:36
    gg(3,i,1)=nanmean(g(3,i,83:119));
    gg(3,i,2)=nanmean(g(3,i,155:179));
    gg(3,i,3)=NaN;
    mm(3,i,1)=0;
    mm(3,i,2)=0;
    mm(3,i,3)=NaN;
end

% plot genotypes' mexXY vs growth at 0, 4, 12 hrs
tt=[0 4 12];
for i=1:3
    subplot(3,3,6+i)
    for n=1:3
        hold on
        scatter(squeeze(mm(n,:,i)),squeeze(gg(n,:,i)),50,col(n,:),'filled')
    end
    axis([0 5 0 1.7])
    set(gca,'FontSize',15,'XTick',[0 2 4 6],'YTick',[0 0.5 1 1.5],'box','off')
    ylabel('Growth (doub./h)','FontSize',20)
    xlabel('MexXY expr. (norm.)','FontSize',20)
    text(2.5,1.6,[num2str(tt(i)) ' hours'],'FontSize',20)
end