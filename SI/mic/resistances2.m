function N=resistances2(M,drugx,numbers)

d=size(M,1);
N=NaN(d,2);

drug=log10(drugx);
drug(1)=drug(2)^2/drug(3);

figure

for i=1:d
    
    n=numbers(i);
    if n==5000
        name='PAO1';
    elseif n==5001
        name='PA14';
    elseif n==5002
        name='ΔmexZ';
    elseif n==5003
        name='ΔmexY';
    else
        name=['IPC' num2str(n)];
    end

    %drug concentration where growth is reduced by half
    
    v=M(i,:);
    thresh=M(i,1)/2;
    
    i1=find(v==0,1);
    if isempty(i1)
        i1=length(v);
    end
    
    i1=max(i1,3);
    ii=[i1-5:i1];
    ii=ii(ii>0);
    
    %f2=fittype( 'power2' );
    %pg = fit( drug(ii)' , v(ii)' , f2 );

    % The bounds correspond to the coefficients [a, b, c]
    opts = fitoptions('power2');
    opts.Lower = [-Inf, 0, -Inf];
    pg = fit( drug(ii)' , v(ii)' , 'power2', opts );
    
    drug_range=linspace(min(drug(ii)),1+max(drug(ii)),1000); 
    vy = feval( pg, drug_range );
    
    iy1 = find( vy < thresh ,1);
    y1 = drug_range(iy1);
    iy2 = find( vy < 0 ,1);
    y2 = drug_range(iy2);
    
    if(isempty(y1))
        N(i,1)=15000;%10^max(drug);
    else
        N(i,1)=min(15000,10^y1);
    end

    if(isempty(y2))
        N(i,2)=15000;%10^max(drug);
    else
        N(i,2)=min(15000,10^y2);
    end
    
    subplot(7,7,i)
    plot(drugx,v,'ko')
    hold on
    plot(drugx(ii),v(ii),'ro')
    vy(vy<0)=NaN;
    plot(10.^drug_range,vy,'b')
    plot(10.^[min(drug-1) max(drug+1)],thresh*[1 1],'--k')
    plot(10.^[min(drug-1) max(drug+1)],[0 0],'--k')
    axis([100 10000 0 0.35])
    set(gca,'XScale','log')
    if(i==43) 
        set(gca,'box','off','Xtick',[1 10 100 1000])
        ylabel('Growth (doub./h)')
        xlabel('Spec (\mug/ml')
    else
        axis off
    end
    
    title(name)

end