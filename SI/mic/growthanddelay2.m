function M=growthanddelay2(data0)
% t_drug is time the drug was added in minutes

data=data0.data;
time=data0.time;
t_drug=data0.tdrug;
numbers=data0.numbers;

d1=size(data,1);
d2=size(data,2);
M=zeros(d1,d2);

for i=1:d1
    
    m=mod(i-1,10);
    if(m==0) figure; end

    t0=time(i,:);
    %t=squeeze(t(~isnan(t)));

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

        if(j==1) % 1st index is growth with no drug 
            t1=t;
            v1=v;
        end

        o1=-3.2;
        i1=find(v>o1,1);
        
        if(~isempty(i1)) 

            mm=max(v);
            o2=max(o1+0.5,mm-0.5); % 0.5, 0.2

            i2=find(v(i1:end)>o2,1);
            
            if(~isempty(i2))      
                i2=i1+i2-1;
            else
                i2=length(v);
            end

            % growth
            c=polyfit(t(i1:i2),v(i1:i2)',1);
            M(i,j)=c(1);
               
        end 
        
        %subplot(d2,d1,(j-1)*d1+i)
        subplot(10,8,m*8+j)
        plot(t(5:end),v(5:end),'b')
        hold on
        plot(t1(5:end),v1(5:end),'--k','LineWidth',2)
        if(~isempty(i1)) 
            plot(t(i1:i2),polyval(c,t(i1:i2)),'r','LineWidth',3)
        end
        %plot(t(i2),v(i2),'ro')
        axis([0 27 -3.85 0])
        if j==1
            n=numbers(i);
            if n==5000
                text(0,0,'PAO1')
            elseif n==5001
                text(0,0,'PA14')
            elseif n==5002
                text(0,0,'ΔmexZ')
            elseif n==5003
                text(0,0,'ΔmexY')
            else
                text(0,0.5,['IPC' num2str(n)])
            end
        end
        
        if((m==9 || i==d1) && j==1) 
            set(gca,'box','off')
            ylabel('growth (doub.)')
            xlabel('Time (hours)')
        else
            axis off
        end
        
    end
 
end


