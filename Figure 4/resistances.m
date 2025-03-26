function [N,vxAll,vyAll,drug,drug_range,threshD]=resistances(M)
    
    drugx = [0,337,436,562,726,938,1212,1565,2021,2610];
    drug=log10(drugx);
    drug(1)=drug(2)^2/drug(3);
    %drug(1)=0;
    threshD = 1/(mean(M(1,:,2)));
    drug_range=linspace(drug(2),1+drug(end),1000);
    
    N=NaN(size(M,2),3);
    
    figure
    
    for i=1:size(M,2)
        
        % growth rate without drug
        N(i,1)=M(1,i,2);
        
        %drug concentration where delay is above a doubling time

        v=M(:,i,1);
        thresh=1/N(i,1);

        %i1=find(v>thresh+2,1);
        %if(isempty(i1)) i1=size(M,1); end
        %ii=[i1-3:i1];
        [a,b]=max(v);
        %ii=[b-5:b];
        ii=[2:b];

        f1=fittype( 'exp2' );
        pd = fit( drug(ii)' , v(ii) , f1 ,'Normalize','on');%,'lower',[0,0]);

        %drug_range=linspace(min(drug(ii)),1+max(drug(ii)),1000);
        vx = feval( pd, drug_range );

        ix = find( vx > thresh , 1);
        x = drug_range(ix);

        if(isempty(x))
            N(i,2)=10^max(drug);
        else
            N(i,2)=10^x;
        end
        
        subplot(2,3,floor((i-1)/3)+1)
        plot(drugx,v,'ko')
        hold on
        plot(drugx(ii),v(ii),'ro')
        vx(vx>v(ii(end)))=NaN;
        plot(10.^drug_range,vx,'b')
        plot(10.^[min(drug-1) max(drug+1)],thresh*[1 1],'--k')
        axis([drugx(1) drugx(end) -2.0 30])
        set(gca,'XScale','log')
        

        %drug concentration where growth is reduced by half

        v=M(:,i,2);
        thresh=M(1,i,2)/2;

        i1=find(v==0,1);
        if isempty(i1)
            i1=length(v);
        end

        %ii=[i1-5:i1];
        ii=[2:i1];
        %ii=ii(ii>0);

        f2=fittype( 'power2' );
        pg = fit( drug(ii)' , v(ii) , f2 );%,'lower',[-inf,0,0],'upper',[0,+inf,+inf]);

        %drug_range=linspace(min(drug(ii)),1+max(drug(ii)),1000); 
        vy = feval( pg, drug_range );

        iy = find( vy < thresh ,1);
        y = drug_range(iy);

        if(isempty(y))
            N(i,3)=10^max(drug);
        else
            N(i,3)=10^y;
        end

        subplot(2,3,3+floor((i-1)/3)+1)
        plot(drugx,v,'ko')
        hold on
        plot(drugx(ii),v(ii),'ro')
        vy(vy<0)=NaN;
        plot(10.^drug_range,vy,'b')
        plot(10.^[min(drug-1) max(drug+1)],thresh*[1 1],'--k')
        axis([drugx(1) drugx(end) 0 0.6])
        set(gca,'XScale','log')
       
        
        % Output all vx, vy data for confidence intervals
        if i == 1
            vxAll = zeros(size(M,2),size(vx,1));
            vyAll = zeros(size(M,2),size(vy,1));
        end
        vxAll(i,:) = vx;
        vyAll(i,:) = vy;
    
    end

end