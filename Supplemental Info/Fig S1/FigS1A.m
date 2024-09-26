%% histogram of divisions

load data

col(1,:)=[0 0 0];
col(2,:)=[0.4660 0.6740 0.1880];
col(3,:)=[0.6350 0.0780 0.1840];

c1 = histogram(div_count(find(div_count==0)),[-0.5 0.5],'FaceColor',col(1,:),'FaceAlpha',1);
hold on
c2 = histogram(div_count(find(div_count==1)),[0.5 1.5],'FaceColor',col(2,:),'FaceAlpha',1);
histogram(div_count(find(div_count==2)),[1.5 2.5],'FaceColor',col(2,:),'FaceAlpha',1)
c3 = histogram(div_count(find(div_count==3)),[2.5 3.5],'FaceColor',col(3,:),'FaceAlpha',1);
histogram(div_count(find(div_count==4)),[3.5 4.5],'FaceColor',col(3,:),'FaceAlpha',1)
histogram(div_count(find(div_count==5)),[4.5 5.5],'FaceColor',col(3,:),'FaceAlpha',1)
plot([2.5 2.5],[-5 20],'--k','LineWidth',6)
plot([0.5 0.5],[-5 20],'--k','LineWidth',6)

axis([-0.75 5.75 0 18])
set(gca,'FontSize',15,'XTick',[0 1 2 3 4 5],'YTick',[0 5 10 15],'box','off')
xlabel('Division events','FontSize',20)
ylabel('Count','FontSize',20)

l=legend([c1,c2,c3],'Arrested','Moribund','Recovered');
l.FontSize=20;
set(findall(gcf,'-property','FontSize'),'FontSize',44)