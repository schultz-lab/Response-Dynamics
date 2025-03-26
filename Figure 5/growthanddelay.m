function M=growthanddelay(data0)
% t_drug is time the drug was added in minutes

data=data0.data;
time=data0.time;
t_drug=data0.tdrug;
numbers=data0.numbers;

d1=size(data,1);
d2=size(data,2);
M=NaN(d1,d2,2); % delay, growth
M(:,:,1)=20;
M(:,:,2)=0;

for i=1:d1
    
    m=mod(i-1,11);
    if(m==0) figure; end

    t0=time(i,:);
    %t=squeeze(t(~isnan(t)));
    i1=find(t0>=t_drug(i),1);

    for j=1:d2     

        v=data(i,j,:);
        v=squeeze(v(~isnan(v)));
        t=squeeze(t0(~isnan(v)));
        %v=filter_data(v);
        v=medfilt1(v,50);
        v=log2(v);
%         v(i1:i1+1)=(v(i1-1)+v(i1+2))/2;
%         for ii=2:length(v)
%             if v(ii)-v(ii-1)>0.2
%                 v(ii)=v(ii-1);
%             end
%         end

        o1=v(i1); %log OD at time drug added        
        o2=o1+1; %log OD at time drug added


        %row at which log OD is 1 doubling from drug added OD
        i2=find(v(i1:end)>o2,1);
        
        if(~isempty(i2)) 
            
            i2=i2+i1-1;

            if(j==1) 
                tt=t(i2);
                t1=t;
                v1=v;
            end

            % delay
            M(i,j,1)=t(i2)-tt;

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
            M(i,j,2)=c(1);
               
        end 
        
        %subplot(d2,d1,(j-1)*d1+i)
        subplot(11,8,m*8+j)
        plot(t,v,'b')
        hold on
        plot(t_drug(i)*[1 1],[-3.6 -2.5],':k','LineWidth',1)
        plot(t1,v1,'--k','LineWidth',2)
        if(~isempty(i2)) 
            plot(t(i3:i4),polyval(c,t(i3:i4)),'r','LineWidth',3)
        end
        plot(t(i2),v(i2),'ro')
        axis([0 27 -3.85 0])
        if j==1
            n=numbers(i);
            if n==5000
                text(0,-1,'PAO1')
            elseif n==5001
                text(0,-1,'PA14')
            else
                text(0,-1,['IPC' num2str(n)])
            end
        end
        
        if(m==10 && j==1) 
            set(gca,'box','off')
            ylabel('growth (doub.)')
            xlabel('Time (hours)')
        else
            axis off
        end
        
    end
 
end


