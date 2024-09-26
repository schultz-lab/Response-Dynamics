function [N,vxAll,vyAll,drug,drug_range,threshD]=resistances(M)
    drug = [0,337,436,562,726,938,1212,1565,2021,2610];
    drug=log10(drug);
    drug(1)=0;
    threshD = 1/(mean(M(1,:,2)));
    
    N=NaN(size(M,2),3);
    
    for i=1:size(M,2)
       
        % growth rate without drug
        N(i,1)=max(M(:,i,2));
    
        % remove any NaN values (inf delay) for curve fitting
        ii=find(~isnan(M(:,i,1)));
        
        drug_range=linspace(drug(2),max(drug)+0.5,1000);
        
        fitDyn = fit(drug(2:ii(end))',M(2:ii(end),i,1),'cubicspline');
        vx = fitDyn(drug_range);

        % Find delay from fit curve
        ix = find( vx > threshD , 1);
        x = drug_range(ix);
        if(isempty(x))
            N(i,2)=10^max(drug);
        else
            N(i,2)=10^x;
        end
        
        % drug concentration at growth is reduced by half
        ii=find(~isnan(M(2:end,i,2)));
        ii=ii+1;
    
        fitSS = fit(drug(2:ii(end))',M(2:ii(end),i,2),'cubicspline');
        vy = fitSS(drug_range);
    
        iy = find( vy < max(M(:,i,2))/2 ,1);

        y = drug_range(iy);
        if(isempty(y))
            N(i,3)=10^max(drug);
        else
            N(i,3)=10^y;
        end
        
        % Output all vx, vy data for confidence intervals
        if i == 1
            vxAll = zeros(size(M,2),size(vx,1));
            vyAll = zeros(size(M,2),size(vy,1));
        end
        vxAll(i,:) = vx;
        vyAll(i,:) = vy;
        
        % Show resistance plot
        
        % figure(6)
        % subplot(2,10,i)
        % plot(drug,squeeze(M(:,i,1)),'ro')
        % hold on
        % plot(drug_range,vx,'b')
        % plot([0 max(drug)+1],[threshD threshD],'--k')
        % axis([0 4 0 20])
        % xlabel('log_{10}(drug)')
        % ylabel('delay (hours)')
        % 
        % subplot(2,size(M,2),size(M,2)+i)
        % plot(drug,squeeze(M(:,i,2)),'ro')
        % hold on
        % plot(drug_range,vy,'b')
        % plot([0 max(drug)+1], M(1,i,2)/2*[1 1],'--k')
        % axis([0 4 0 0.4])
        % xlabel('log_{10}(drug)')
        % ylabel('growth (doub/h)')
    
    end

end