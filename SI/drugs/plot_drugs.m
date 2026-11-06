load data

ii=[11 9 5 11];
time=[0:1/12:(length(data)-1)/12]-4.5;


for i=1:4
    j = ii(i);

    subplot(1,4,i)

    x1=squeeze(log2(data(1,i,:)));
    x=squeeze(log2(data(j,i,:)));
    x1=x1-x(55);
    x=x-x(55);

    plot(time,x1,'--k','LineWidth',3)
    hold on
    plot(time,x,'Color',[0 0.5 1],'LineWidth',3)
    plot([0 0],[-1 3],':k')
    axis([-4.5 45 -1 3.5])
    
    set(gca,'FontSIze',15,'YTick',[0:3])
    xlabel('Time (hours)','FontSIze',20)
    ylabel('doublings','FontSIze',20)
    
    grid off
    box off

end