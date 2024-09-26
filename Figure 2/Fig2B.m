load data

col(1,:)=[0 0.4470 0.7410];
col(2,:)=[0.8500 0.3250 0.0980];
col(3,:)=[0.9290 0.6940 0.1250];

% Plot accumulated growth. Set accumulated growth to 0 at t=0 (when drug is added)
figure
for i=1:36
for n=1:3
    hold on
    plot(t(n,:),squeeze(a(n,i,:)-a(n,i,find(t(n,:)==0))),'Color',col(n,:),'LineWidth',1)
    plot(squeeze(d(n,i,:).*t(n,:)),squeeze(d(n,i,:).*(a(n,i,:)-a(n,i,find(t(n,:)==0)))),'.','MarkerSize',20,'Color',col(n,:),'LineWidth',1)
end
end

plot([0 0],[-4 12],'--k','LineWidth',2)
plot([-4 12],[0 0],'--k','LineWidth',2)
axis([-4 12 -4 12])
set(gca,'FontSize',15,'XTick',[-4 0 4 8 12],'YTick',[-4 0 4 8 12])
xlabel('Time (hours)','FontSize',20)
ylabel('Accumulated growth (doublings)','FontSize',20)
