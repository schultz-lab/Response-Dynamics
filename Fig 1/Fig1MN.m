load data2

%% pre-drug WT mexXY vs many things

accuGrowth = max(a(1,:,:),[],3)-a(1,:,59);
div = sum(d(1,:,70:end),3,"omitnan");
lens = squeeze(blobsGlobal(:,3,:));
lenAtDrug = mean(lens(:,57:59),2);


% convert any cells not growing at end to zero growth rate.. try two
% different averaging techniques
growthRateLen1 = mean(g(1,:,204-30:204),3);
growthRateLen1(isnan(growthRateLen1))=0;

growthRateLen2 = mean(g(1,:,204-1:204),3);
growthRateLen2(isnan(growthRateLen2))=0;

gr = zeros(2,36);
gr(1,:) = growthRateLen1;
gr(2,:) = growthRateLen2;

% begin grow
growthRateBeg = mean(g(1,:,59-20:59),3,"omitnan");

% basal mexXY
basalMexxy1 = mean(m(1,:,1:59),3,"omitnan");
basalMexxy2 = mean(m(1,:,20:59),3,"omitnan");

bas = zeros(2,36);
bas(1,:) = basalMexxy1;
bas(2,:) = basalMexxy2;

for BAS = 1
    b = bas(BAS,:);
    for GROW = 1
        gro = gr(GROW,:);
        figure

        subplot(1,2,1)
        x=b;
        y=gro;
        scatter(x,y,75,[1 0.4 0],'filled','MarkerEdgeColor','none','LineWidth',1);
        xlabel('Pre-drug MexXY (norm.)','FontSize',20)
        ylabel('Final growth (doub./h)','FontSize',20)
        %r = corrcoef(x,y);
        mdl = fitlm(x, y);
        yhat = predict(mdl, x');
        r = corrcoef(y, yhat);
        r2 = r(1,2)^2;
        r=string(round(r(2),2));
        r2=string(round(r2,2));
        pval=mdl.Coefficients.pValue(2);
        pval=string(round(pval,2));
        hold on
        plot(x,yhat,'-k')
        out1 = [strcat("{\itr} = ",r) strcat("R^2 = ",r2) strcat("p = ",pval)];
        
        axis([0.5 1.4 -0.2 0.7])
        set(gca,'FontSize',15)
        text(0.55,0.5,out1,'FontSize',20)
        

        subplot(1,2,2)
        x=growthRateBeg;
        y=gro;
        scatter(x,y,75,[0.7 0 0.5],'filled','MarkerEdgeColor','none','LineWidth',1);
        xlabel('Pre-drug growth (doub./h)','FontSize',20)
        ylabel('Final growth (doub./h)','FontSize',20)
        %r = corrcoef(x,y);
        mdl = fitlm(x, y);
        yhat = predict(mdl, x');
        r = corrcoef(y, yhat);
        r2 = r(1,2)^2;
        r=string(round(r(2),2));
        r2=string(round(r2,2));
        pval=mdl.Coefficients.pValue(2);
        pval=string(round(pval,2));
        hold on
        plot(x,yhat,'-k')
        out2 = [strcat("{\itr} = ",r) strcat("R^2 = ",r2) strcat("p = ",pval)];
        
        axis([0.3 1.5 -0.2 0.7])
        set(gca,'FontSize',15)
        text(0.5,0.5,out2,'FontSize',20)
        
        
    end
end
