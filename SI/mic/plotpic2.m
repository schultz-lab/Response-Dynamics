figure

N=readmatrix('resistances.csv');

subplot(1,2,1)

scatter(N(:,8),N(:,7),100,'filled')
hold on
plot([0 15000],[0 15000],'--k')

set(gca,'FontSize',15)
ylabel('IC_{50} (spec. μg/mL)','FontSize',20)
xlabel('MIC (spec. μg/mL)','FontSize',20)
ylim([0 15000])
xlim([0 15000])


subplot(1,2,2)

scatter(N(:,5),N(:,7),100,'filled')
hold on
plot([0 15000],[0 15000],'--k')

set(gca,'FontSize',15)
ylabel('IC_{50} (spec. μg/mL)','FontSize',20)
xlabel('Steady-state resistance (spec. μg/mL)','FontSize',20)
ylim([0 15000])
xlim([0 2500])