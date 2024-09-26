load data

col(1,:)=[0 0 0];
col(2,:)=[0.4660 0.6740 0.1880];
col(3,:)=[0.6350 0.0780 0.1840];

% Plot accumulated growth. Drug added at frame 60 (t=0); set um to 0 at t=0
figure
for i=1:36
    hold on
    plot(t,a(i,:)-a(i,59),'Color',col(j(i),:),'LineWidth',2)
    plot(d(i,:).*t,d(i,:).*(a(i,:)-a(i,59)),'.','MarkerSize',60,'Color',col(j(i),:),'LineWidth',1)
end

plot([0 0],[-4 6],'--k','LineWidth',2)
plot([-3 12],[0 0],'--k','LineWidth',2)
axis([-3 12 -3 6])
set(gca,'FontSize',15,'XTick',[-3 0 3 6 9 12],'YTick',[-3 0 3 6 9 12])
xlabel('Time (hours)','FontSize',44)

set(findall(gcf,'-property','FontSize'),'FontSize',44)
ylabel('Accumulated growth (doublings)','FontSize',36)
set(gcf, 'Position',  [20, 20, 1000, 1000])