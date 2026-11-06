function M=growthanddelay1(data0)

data=data0.data;
time=data0.time;
numbers=data0.numbers;

M=zeros(8,12);

for i=1:8

    t0=time(i,:);
    %t=squeeze(t(~isnan(t)));

    for j=1:12     

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

        o1=-3.2; %-3.25
        i1=find(v>o1,1);
        
        if(~isempty(i1)) 

            mm=max(v);
            o2=max(o1+0.75,mm-0.75); % 1, 0.75

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
        
        subplot(8,12,(i-1)*12+j)
        plot(t,v,'b')
        hold on
        plot(t1,v1,'--k','LineWidth',2)
        if(~isempty(i1)) 
            plot(t(i1:i2),polyval(c,t(i1:i2)),'r','LineWidth',3)
        end
        %plot(t(i2),v(i2),'ro')
        axis([0 max(t) -3.6 0])
        %text(5,0,numbers(i))
        
        if(any(i==[3 6 8]) && j==1) 
            set(gca,'box','off')
            ylabel('growth (doub.)')
            xlabel('Time (hours)')
        else
            axis off
        end
        
    end
 
end


