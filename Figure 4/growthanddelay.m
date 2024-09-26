function M=growthanddelay(data)
% t_drug is time the drug was added in minutes

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
        
        p=i;
        v=d(:,j,p);

        o1=v(i1);

        o2=o1+1;
        i2=find(v(i1:end)>o2,1);

        if(~isempty(i2)) i2=i2+i1-1; end

        if ~isempty(i2)

            if(j==1) tt=t(i2); end
            M(j,i,1)=t(i2)-tt; % 1 is for delay
            % account for time it took to add drug.. about 5 min.. and 2
            % deleted rows due to condensation (another 10 min)
            if j > 1
                M(j,i,1) = M(j,i,1) +15/60;
            end

            o3=o2+1; 

            i3=find(v(i2:end)>o3,1);
            if(~isempty(i3)) i3=i3+i2-1; end

            if(isempty(i3)) i3=length(d); end

            c=polyfit(t(i2:i3),v(i2:i3)',1);
            M(j,i,2)=c(1); % 2 is growth rate

        end
        % Show plot
        
        % figure(5)
        % subplot(size(d,3),size(d,2),(i-1)*10+j)
        % 
        % plot(t,v,'b')
        % hold on
        % xlim([-2 36])
        % ylim([-0.4 3])
        % plot([0 0],[-5 5],'--k','LineWidth',1)
        % plot(t,squeeze(d(:,1,p)),'--k','LineWidth',2)
        % if ~isempty(i3)
        %     plot(t(i2:i3),polyval(c,t(i2:i3)),'r','LineWidth',3)
        %     plot([tt t(i2)],o2*[1 1],'--k')
        % end
        % 
        % axis off
        
    end
end

% Set first no-growth entry to 0 instead of NaN for steady-state
for c = 1:size(M,2)
    holdGrowth=M(:,c,2);
    checkNaN = isnan(holdGrowth);
    idx = find(checkNaN==1,1);
    M(idx,c,2) = 0;
end

end



