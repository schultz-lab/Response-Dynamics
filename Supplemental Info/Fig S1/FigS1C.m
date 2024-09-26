% Use data from Fig1EFG
load data

%% Get which cell to track for Fig 1C
% best recovered = cell 30 (highest mexXY)
% worst arrested = cell 10 (4th lowest mexXY; lowest not growing before drug, 2nd lowest lyses, 3rd lowest lyses)
% medium-est moribund = cell 5 (2nd middle-est mexXY.. middle has 2 mother cells)

% wt arrest
ii=find(j==1);
maxExp = max(m(ii,80:end-4),[],2);

sortedCells = sort(maxExp);
trackCell = find(maxExp > sortedCells(4)-0.01 & maxExp < sortedCells(4)+0.01);
% arrested cell used in 1C
markedDot(1) = ii(trackCell);

% wt moribund
ii=find(j==2);
maxExp = max(m(ii,80:end-4),[],2);

sortedCells = sort(maxExp);
trackCell = find(maxExp > sortedCells(4)-0.01 & maxExp < sortedCells(4)+0.01);
% moribund cell used in 1C
markedDot(2) = ii(trackCell);

% wt recover
ii=find(j==3);
maxExp = max(m(ii,80:end-4),[],2);

sortedCells = sort(maxExp);
trackCell = find(maxExp > sortedCells(end)-0.01 & maxExp < sortedCells(end)+0.01);
% recovered cell used in 1C
markedDot(3) = ii(trackCell);

%% Plotting

col(1,:)=[0 0 0];
col(2,:)=[0.4660 0.6740 0.1880];
col(3,:)=[0.6350 0.0780 0.1840];

lgdText(1,:) = cellstr('Recovered');
lgdText(2,:) = cellstr('Moribund');
lgdText(3,:) = cellstr('Arrested');

figure;
for k = [3 2 1]
    ii=find(j==k);
    
    % Plot scatter of all in each category
    maxExp = max(m(ii,80:end-4),[],2);
    maxGro = max(g(ii,80:end-4),[],2);
    
    scatter(maxGro,maxExp,350,col(k,:),'filled')
    
    hold on
end

ylabel('MexXY expr. (norm.)','FontSize',16)
xlabel('Growth (doub./h)','FontSize',16)

% r value
maxExp = max(m(:,80:end-4),[],2);
maxGro = max(g(:,80:end-4),[],2);
r = corrcoef(maxExp,maxGro);
r=string(round(r(2),2));
outText = strcat("{\itr} = ",r);
text(0.01,4.5,outText,'FontSize',44)

% Plot large scatter for cells used for Fig 1C
for k = 1:3
    % Plot large scatter for cell used in fig 1C
    maxExp = max(m(markedDot(k),80:end-4),[],2);
    maxGro = max(g(markedDot(k),80:end-4),[],2);
    
    scatter(maxGro,maxExp,850,col(k,:),'filled','MarkerEdgeColor',[0 0 0],'LineWidth',4)
end

set(findall(gcf,'-property','FontSize'),'FontSize',44)
