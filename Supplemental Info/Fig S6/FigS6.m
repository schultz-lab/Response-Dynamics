%% Data input
load data

%% Growth rate and delay after drug addition

t_drug = 2.08;
M=NaN(10,9,2);
t=data.time;
d=data.data;

% time drug was added; make time relative to t=t_drug
i1=find(t>=t_drug,1)+1;
t=t-t_drug;

% correction for condensation after drug is added
d(i1,:,:)=[];
d(i1,:,:)=[];
t(i1)=[];
t(i1)=[];

% Convert data to doublings; doublings relative to time drug is added
d = log2(d);
d = d - d(1,:,:);
d = d - d(i1);

for i=1:size(d,3) 
    for j=1:size(d,2)
        
        v=d(:,j,i);
        o1=v(i1);

        o2=o1+1;
        i2=find(v(i1:end)>o2,1);

        if(~isempty(i2)) i2=i2+i1-1; end

        if ~isempty(i2)

            if(j==1) tt=t(i2); end

            o3=o2+1; 

            i3=find(v(i2:end)>o3,1);
            if(~isempty(i3)) i3=i3+i2-1; end

            if(isempty(i3)) i3=length(d); end

            c=polyfit(t(i2:i3),v(i2:i3)',1);

        end
        figure(35)
        subplot(size(d,3),size(d,2),(i-1)*10+j)

        plot(t,v,'b')
        hold on
        xlim([-2 36])
        ylim([-0.4 3])
        plot([0 0],[-5 5],'--k','LineWidth',1)
        plot(t,squeeze(d(:,1,i)),'--k','LineWidth',2)
        if ~isempty(i3)
            plot(t(i2:i3),polyval(c,t(i2:i3)),'r','LineWidth',3)
            plot([tt t(i2)],o2*[1 1],'--k')
        end

        % Only display axis on bottom left
        if i == size(d,3) && j == 1
            axis on
            set(gca,'XTick',[0 20],'YTick',[0 3])
            set(gca,'box','off');
            xlim([-2 36])
            ylim([-0.4 3])
        else
            axis off
            xlim([-2 36])
            ylim([-0.4 3])
        end
        
    end
end