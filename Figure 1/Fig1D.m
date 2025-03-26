load data

col(1,:)=[1 1 1];
col(2,:)=[0.8 0.8 0.8];
col(3,:)=[0 0 0];
col(4,:)=[0.4660 0.6740 0.1880];
col(5,:)=[0.6350 0.0780 0.1840];
colormap(col)

v=repmat(j',1,204);
D=ones(size(d));
D(:,60:69)=2;
D(d==1 & v==1)=3;
D(d==1 & v==2)=4;
D(d==1 & v==3)=5;

imagesc(t,[1:36],D)
set(gca,'FontSize',15)
xlabel('Time (hours)','FontSize',20)
ylabel('Cells','FontSize',20)