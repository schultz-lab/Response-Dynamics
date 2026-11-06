function M=growthanddelay(data)
% t_drug is time the drug was added in hours

t_drug = 2.08;
t=data.time;
ii=find(data.time<42);
d=data.data(ii,:,:);
t=data.time(ii);

i1=find(t>=t_drug,1);
d(i1+1,:,:)=(d(i1,:,:)+d(i1+3,:,:))/2;
d(i1+2,:,:)=(d(i1,:,:)+d(i1+3,:,:))/2;

M=NaN(10,9,3); % delay, growth
M(:,:,1)=20;
M(:,:,2)=0;
M(:,:,3)=0;

figure

for i=1:9

    for j=1:10    

        v=log2(d(:,j,i));

        o1=v(i1); %log OD at time drug added        
        o2=o1+1; %log OD at time drug added

        %row at which log OD is 1 doubling from drug added OD
        i2=find(v(i1:end)>o2,1);
        
        if(~isempty(i2)) 
            
            i2=i2+i1-1;

            if(j==1) tt=t(i2); end

            % delay
            M(j,i,1)=t(i2)-tt;

            o3=o2;
            mm=max(v);
            o4=max(o3+0.5,mm-0.2);

            i3=find(v(i2:end)>o3,1);
            
            if(~isempty(i3)) 
                
                i3=i3+i2-1;
                i4=find(v(i3:end)>=o4,1);
                
                if(~isempty(i4))
                    i4=i4+i3-1;
                else
                    i4=length(v);
                end
            end

            % growth
            c=polyfit(t(i3:i4),v(i3:i4)',1);
            M(j,i,2)=c(1);
            
            % survival
            os=polyval(c,t(i1));
            M(j,i,3)=2^(os-o1);
            
        end     
            
        subplot(9,10,(i-1)*10+j)

        plot(t-t_drug,v,'b')
        hold on
        %plot([0 0],[-3.2 0],'--k','LineWidth',1)
        %plot(t-t_drug,squeeze(log2(d(:,1,i))),'--k','LineWidth',2)
        if ~isempty(i2)
            plot(t(i3:i4)-t_drug,polyval(c,t(i3:i4)),'r','LineWidth',3)
            plot([tt t(i2)]-t_drug,o2*[1 1],'--k')
        end
        xlim([-2 40])
        ylim([-3.3 0])
        set(gca,'box','off')

        % Only display axis on bottom left
        if i == 9 && j == 1
            axis on
            set(gca,'XTick',[0 15 30],'YTick',[-3 -2 -1])
        else
            axis off
        end
        
    end
 
end