load data

M=growthanddelay(data);

N=resistances(M,data.drug,data.numbers);

N(N>2500)=2500;

z=[4 20 23 32 40 41 42 43];

figure

scatter(N(:,2),N(:,1),100,'filled')
hold on
h1=scatter(N(31,2),N(31,1),100,[0 0.7 0],'filled');
h2=scatter(N(z,2),N(z,1),100,[0.8500 0.3250 0.0980],'filled');
plot([0 2500],[0 2500],'--k')

set(gca,'FontSize',15)
xlabel('Steady-state resistance (spec. μg/mL)','FontSize',20)
ylabel('Dynamical resistance (spec. μg/mL)','FontSize',20)
xlim([0 2500])
ylim([0 2500])
l=legend([h1,h2],'PA14','{\itmexZ} truncations','Location','best');
l.FontSize=20;

for i=1:44
    x(i).IPCD=data.numbers(i);
    x(i).DynRes=N(i,1);
    x(i).SSRes=N(i,2);
end

writetable(struct2table(x),'resistances.csv')