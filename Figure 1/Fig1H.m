load data

%% smoothing of data before it is used for prediction

i=1;
stepLoop = 7;
gg = zeros(size(a,1),(size(a,2)-1)/stepLoop+1);
mm = zeros(size(a,1),(size(a,2)-1)/stepLoop+1);

for timept = 1:stepLoop:size(a,2)
    for cell = 1:size(a,1)
        endpt = timept+stepLoop;
        if timept+stepLoop > size(a,2)
            endpt = size(a,2);
        end
        gg(cell,i) = mean(g(cell,timept:endpt),"omitnan");
        mm(cell,i) = mean(m(cell,timept:endpt),"omitnan");
    end
    i=i+1;
end

gg = smoothdata(gg,2,"movmean",[4,1],"omitmissing");
mm = smoothdata(mm,2,"movmean",[4,1],"omitmissing");

% fill in smoothed gaps
gSmooth = zeros(size(g,1),size(g,2));
mSmooth = zeros(size(g,1),size(g,2));

for cell=1:size(gg,1)
    gSmooth(cell,:) = interp1(1:stepLoop:size(a,2),gg(cell,:),1:1:size(a,2));
    mSmooth(cell,:) = interp1(1:stepLoop:size(a,2),mm(cell,:),1:1:size(a,2));
end


%% infogain of mexXY, growth
infoG=zeros(size(gSmooth,2),1);
infoM=zeros(size(gSmooth,2),1);
infoA=zeros(size(gSmooth,2),1);
infoR=zeros(size(gSmooth,2),1);
infoC=zeros(size(gSmooth,2),1);

for frame=1:size(gSmooth,2)

    % instantaneous growth
    [x1,infoG(frame)]=infogain(gSmooth(j<3,frame)',gSmooth(j==3,frame)');
    
    % norm. mexXY
    [x2,infoM(frame)]=infogain(mSmooth(j<3,frame)',mSmooth(j==3,frame)');

end

%%
figure
plot(t,smoothdata(infoG,1,"movmean",[3,3]),'Color',"#7E2F8E",'LineWidth',5)
hold on
plot(t,smoothdata(infoM,1,"movmean",[3,3]),'Color',"#880808",'LineWidth',5)

plot([0 0],[0 1],'--k','LineWidth',3)
axis([-1 12 0 1])
box off
xlabel('Time (hours)','FontSize',20)
ylabel('Predictive Power','FontSize',20)
set(gca,'FontSize',15,'YTick',[0:0.5:1],'XTick',[-1 4 8 12])

h=legend(' Growth',' MexXY');
h.Location='northwest';
h.FontSize=20;
hold off

set(findall(gcf,'-property','FontSize'),'FontSize',44)
set(gcf, 'Position',  [20, 20, 1000, 1000])
