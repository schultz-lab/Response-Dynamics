load data

col(1,:)=[0 0 0];
col(2,:)=[0.4660 0.6740 0.1880];
col(3,:)=[0.6350 0.0780 0.1840];

% Plot wt growth by category
figure;
subplot(3,3,[1 2 3])
for i=1:36
    hold on
    plot(t(5:end-4),g(i,5:end-4),'Color',0.7*[1 1 1]+0.3*col(j(i),:),'LineWidth',1)
end
for k=1:3
    ii=find(j==k);
    h(k)=plot(t(5:end-4),nanmean(g(ii,5:end-4)),'Color',col(k,:),'LineWidth',3);
end
l=legend([h(1) h(2) h(3)],{'Arrested','Moribund','Recovered'},'AutoUpdate','off');
l.FontSize=15;

plot([0 0],[-0.5 2],'--k','LineWidth',2)
plot([-4 12],[0 0],'--k','LineWidth',2)
axis([-4 12 -0.5 2])
set(gca,'FontSize',15,'XTick',[-4 0 4 8 12],'YTick',[-0.5 0 0.5 1 1.5],'box','off')
xlabel('Time (hours)','FontSize',16)
ylabel('Growth (doub./h)','FontSize',16)

% Plot wt expression by category
subplot(3,3,[4 5 6])
for i=1:36
    hold on
    plot(t(5:end-4),m(i,5:end-4),'Color',0.7*[1 1 1]+0.3*col(j(i),:),'LineWidth',1)
end
for k=1:3
    ii=find(j==k);
    plot(t(5:end-4),nanmean(m(ii,5:end-4)),'Color',col(k,:),'LineWidth',3);
end

plot([0 0],[0 10],'--k','LineWidth',2)
plot([-4 12],[1 1],'--k','LineWidth',2)
axis([-4 12 0 5])
set(gca,'FontSize',15,'XTick',[-4 0 4 8 12],'YTick',[0 2 4],'box','off')
xlabel('Time (hours)','FontSize',16)
ylabel('MexXY expression (norm.)','FontSize',16)

hold off

for i=1:36
    gg(i,1)=mean(g(i,23:59));
    gg(i,2)=mean(g(i,95:119));
    gg(i,3)=mean(g(i,178:203));
    mm(i,1)=mean(m(i,23:59));
    mm(i,2)=mean(m(i,95:119));
    mm(i,3)=mean(m(i,178:203));
end

% Plot growth vs fluorescence by category
tt=[0 4 12];
for i=1:3
    subplot(3,3,6+i)
    for k=1:3
        ii=find(j==k);
        hold on
        scatter(mm(ii,i),gg(ii,i),50,col(k,:),'filled')
    end
    axis([0 5 0 1.5])
    set(gca,'FontSize',15,'XTick',[0 2 4],'YTick',[0 0.5 1 1.5],'box','off')
    ylabel('Growth (doub./h)','FontSize',16)
    xlabel('MexXY expr.','FontSize',16)
    text(2.7,1.4,[num2str(tt(i)) ' hours'],'FontSize',14)

    hold off
end


