load lab_strains_mic

M=growthanddelay1(data);
N=resistances1(M,data.concentrations,data.numbers)

% load IPCD_mic
% 
% M = growthanddelay2(data);
% N = resistances2(M, squeeze(data.concentrations(1,:)), data.numbers);
% 
% for i=1:49
%     x(i).IPCD=data.numbers(i);
%     x(i).IC50=N(i,1);
%     x(i).MIC=N(i,2);
% end
% 
% writetable(struct2table(x),'resistances_mic.csv')


