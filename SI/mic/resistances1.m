function N=resistances1(M,drugx,numbers)

N=NaN(3,2);

drug=log10(drugx);
drug(1)=drug(2)^2/drug(3);

col(1,:)=[0 0.4470 0.7410]; % WT
col(2,:)=[0.8500 0.3250 0.0980]; % mexZ
col(3,:)=[0.9290 0.6940 0.1250]; % mexY

figure

for i=1:3
    
    name=numbers(3*i-1);

    %drug concentration where growth is reduced by half
    
    if i<3
        v=mean(M(3*i+[-2 -1 0],:));
        e=std(M(3*i+[-2 -1 0],:));
    else
        v=mean(M(3*i+[-2 -1],:));
        e=std(M(3*i+[-2 -1],:));
    end

    thresh=v(1)/2;
    
    i1=find(v==0,1);
    if isempty(i1)
        i1=length(v);
    end
    
    %i1=max(i1,3);
    %ii=[i1-5:i1];
    %ii=[3:i1];
    ii=[1:i1];
    ii=ii(ii>0);
    
    % f2=fittype( 'power2' );
    % pg = fit( drug(ii) , v(ii)' , f2 );

    opts = fitoptions('power2');
    opts.Lower = [-Inf, 0, -Inf];
    pg = fit( drug(ii) , v(ii)' , 'power2', opts );
    
    drug_range=linspace(min(drug(ii)),1+max(drug(ii)),1000); 
    vy = feval( pg, drug_range );
    
    iy1 = find( vy < thresh ,1);
    y1 = drug_range(iy1);
    iy2 = find( vy < 0 ,1);
    y2 = drug_range(iy2);
    
    if(isempty(y1))
        N(i,1)=10000;%10^max(drug);
    else
        N(i,1)=10^y1;
    end

    if(isempty(y2))
        N(i,2)=10000;%10^max(drug);
    else
        N(i,2)=10^y2;
    end
    
    subplot(1,3,i)
    hold on
    vy(vy<0)=NaN;
    p(i)=plot(10.^drug_range,vy,'Color',col(i,:),'LineWidth',3);
    errorbar(drugx,v,e,'LineStyle','none','Color','black','LineWidth', 2,'CapSize',14)
    scatter(drugx,v,200,col(i,:),'filled','MarkerEdgeColor','black','LineWidth',3)

    plot(10.^[min(drug-1) max(drug+1)],thresh*[1 1],'--k')
    axis([100 10000 0 0.32])
    set(gca,'XScale','log','FontSize',15,'box','off','Xtick',[100 1000 10000])
    ylabel('Growth rate (doub./h)','FontSize',20)
    xlabel('Spectinomycin (\mug/ml)','FontSize',20)
    l=legend(p,'WT','Δ{\itmexZ}','Δ{\itmexY}','Location','best');
    l.FontSize=20;
    
    %title(name)

end