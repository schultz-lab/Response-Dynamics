load data

for i=1:36
    gg(1,i,1)=mean(g(1,i,23:59));
    gg(1,i,2)=mean(g(1,i,95:119));
    gg(1,i,3)=mean(g(1,i,178:203));
    gg(2,i,1)=mean(g(2,i,30:66));
    gg(2,i,2)=mean(g(2,i,102:126));
    gg(2,i,3)=mean(g(2,i,185:210));
    gg(3,i,1)=mean(g(3,i,83:119));
    gg(3,i,2)=mean(g(3,i,155:179));
    gg(3,i,3)=NaN;
end

for n=1:3
    subplot(3,1,n)
    histogram(gg(n,:,1),'BinWidth',0.1,'FaceColor',[0 0 0])
    hold on
    histogram(gg(n,:,2),'BinWidth',0.1,'FaceColor',[0 0.4470 0.7410])
    histogram(gg(n,:,3),'BinWidth',0.1,'FaceColor',[0.9290 0.6940 0.1250])

    axis([-0.2 1.7 0 12])
    set(gca,'FontSize',15,'XTick',[0 0.5 1 1.5],'YTick',[5 10],'box','off')
    xlabel('Growth rate (doub./h)','FontSize',20)
    ylabel('Count','FontSize',20)

    l=legend('0 hours','5 hours','10 hours');
    l.FontSize=20;
end