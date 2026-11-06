load data

M=growthanddelay(data);

N=resistances(M,data.drug,data.numbers,[0 1]);
N1=resistances(M,data.drug,data.numbers,[0 0.667]);
N2=resistances(M,data.drug,data.numbers,[0 1.5]);
N3=resistances(M,data.drug,data.numbers,[4 0]);

N(N>2500)=2500;
N1(N1>2500)=2500;
N2(N2>2500)=2500;
N3(N3>2500)=2500;

%z=[9    19    20    24    27    29    32    37    43    44    45    47];

figure
subplot(1,2,1)
hold on
h1=scatter(N(:,2),N(:,1),50,[0 0 0],'filled');
h2=scatter(N1(:,2),N1(:,1),50,[0 1 0],'filled');
h3=scatter(N2(:,2),N2(:,1),50,[0 0 1],'filled');
for i=1:length(N)
    plot([N1(i,2) N(i,2)],[N1(i,1) N(i,1)],'-g','LineWidth',1)
    plot([N(i,2) N2(i,2)],[N(i,1) N2(i,1)],'-b','LineWidth',1)
end
plot([25 2500],[25 2500],'--k')

set(gca,'FontSize',15,'XScale','log','YScale','log')
xlabel('Steady-state resistance (spec. μg/mL)','FontSize',20)
ylabel('Dynamical resistance (spec. μg/mL)','FontSize',20)
xlim([40 2500])
ylim([40 2500])
l=legend([h2,h1,h3],'0.67 doub. time','1 doub. time','1.5 doub. time','Location','best');
l.FontSize=20;

subplot(1,2,2)
hold on
h1=scatter(N(:,2),N(:,1),50,[0 0 0],'filled');
h2=scatter(N3(:,2),N3(:,1),50,[1 0 0],'filled');
for i=1:length(N)
    plot([N(i,2) N3(i,2)],[N(i,1) N3(i,1)],'-r','LineWidth',1)
end
plot([25 2500],[25 2500],'--k')

set(gca,'FontSize',15,'XScale','log','YScale','log')
xlabel('Steady-state resistance (spec. μg/mL)','FontSize',20)
ylabel('Dynamical resistance (spec. μg/mL)','FontSize',20)
xlim([40 2500])
ylim([40 2500])
l=legend([h1,h2],'1 doub. time','4 hours','Location','best');
l.FontSize=20;

for i=1:49
    x(i).IPCD=['IPC' num2str(data.numbers(i))];
    x(i).DynRes=N1(i,1);
    x(i).SSRes=N1(i,2);
    if(data.numbers(i)==5000) x(i).IPCD='PAO1'; end
    if(data.numbers(i)==5001) x(i).IPCD='PA14'; end
end
writetable(struct2table(x),'resistances1.csv')

for i=1:49
    x(i).IPCD=['IPC' num2str(data.numbers(i))];
    x(i).DynRes=N2(i,1);
    x(i).SSRes=N2(i,2);
    if(data.numbers(i)==5000) x(i).IPCD='PAO1'; end
    if(data.numbers(i)==5001) x(i).IPCD='PA14'; end
end
writetable(struct2table(x),'resistances2.csv')