%% mother machine strains vs ancestors in drug gradient

load data

for i=1:2:size(GFP,3) 
    for j=1:size(GFP,2)
        lineW = 1;
        % (:,:,1): RFP_high, RFP_low, RFP_mean
        % (:,:,2): OD_high, OD_low, OD_mean

        plotVals = zeros(size(GFP,1),3,2);
        for k = 1:size(GFP,1)

            % normalized RFP
            plotVals(k,1,1) = min(RFP(k,j,i)/OD(k,j,i),RFP(k,j,i+1)/OD(k,j,i+1));
            plotVals(k,2,1) = max(RFP(k,j,i)/OD(k,j,i),RFP(k,j,i+1)/OD(k,j,i+1));
            plotVals(k,3,1) = (RFP(k,j,i)/OD(k,j,i)+RFP(k,j,i+1)/OD(k,j,i+1))/2;
            
            % OD
            plotVals(k,1,2) = min(OD(k,j,i),OD(k,j,i+1));
            plotVals(k,2,2) = max(OD(k,j,i),OD(k,j,i+1));
            plotVals(k,3,2) = (OD(k,j,i)+OD(k,j,i+1))/2;

        end

        % Conf. interval (max and min) of two replicates

        xconf = [t fliplr(t)];
        yconf(:,:,1) = [plotVals(:,1,1) fliplr(plotVals(:,2,1))];
        yconf(:,:,2) = [plotVals(:,1,2) fliplr(plotVals(:,2,2))];

        % OD -> log2(OD)
        plotVals(:,:,2) = log2(plotVals(:,:,2));
        yconf(:,:,2) = log2(yconf(:,:,2));

        % WT
        if i == 1 || i == 3
            figure(1)
            subplot(3,10,j)
            c = col(1,:);
            cfill = col(1,:);
            if i == 3
                c = [1 0 1];
                cfill = [0.4940 0.1840 0.5560];
                lineW = 2;
            end
            p = fill(xconf',yconf(:,:,2)',cfill,'FaceColor',cfill,'EdgeColor',cfill,'FaceAlpha',0.5);
            hold on
            if i == 1
                p6 = plot(t,plotVals(:,3,2),'Color',c,'LineWidth',lineW);
            end
            p7 = plot(t,plotVals(:,3,2),'Color',c,'LineWidth',lineW);
            plot([t_drug t_drug],[-5 0.5],'--k','LineWidth',1)

            xlim([0 24])
            ylim([-4.1 0])
            yticks([-3 -2 -1 0])
            xticks([0 10 20])
            xlabel('Time (hrs)')
            ylabel('Growth (doublings)')
            xtickangle(0)
            if j > 1 
                axis off
            end

            if i == 3 && j == 10
                legend([p6,p7],'WT','WT microflu.','Location','southoutside')
            end

        % KOy
        elseif i == 5 || i == 11
            figure(2)
            subplot(3,10,j)
            c = col(2,:);
            cfill = col(2,:);
            alphaVal = 0.5;
            if i == 11
                c = [1 0 1];
                cfill = [0.4940 0.1840 0.5560];
                alphaVal = 0.5;
                lineW = 2;
            end
            p = fill(xconf',yconf(:,:,2)',cfill,'FaceColor',cfill,'EdgeColor',cfill,'FaceAlpha',alphaVal);
            hold on
            if i == 5
                p4 = plot(t,plotVals(:,3,2),'Color',c,'LineWidth',lineW);
            end
            p3 = plot(t,plotVals(:,3,2),'Color',c,'LineWidth',lineW);
            plot([t_drug t_drug],[-5 0.5],'--k','LineWidth',1)

            xlim([0 24])
            ylim([-4.1 0])
            yticks([-3 -2 -1 0])
            xticks([0 10 20])
            xlabel('Time (hrs)')
            ylabel('Growth (doublings)')
            xtickangle(0)
            if j > 1 
                axis off
            end

            if i == 11 && j == 10
                legend([p4,p3],'Δ{\itmexY}','Δ{\itmexY} microflu.','Location','southoutside')
            end

        % KOz
        elseif i == 7 || i == 9
            figure(3)
            subplot(3,10,j)
            c = col(3,:);
            cfill = col(3,:);
            if i == 9
                c = [1 0 1];
                cfill = [0.4940 0.1840 0.5560];
            end
            p = fill(xconf',yconf(:,:,2)',cfill,'FaceColor',cfill,'EdgeColor',cfill,'FaceAlpha',0.5);
            hold on
            if i == 7
                p1 = plot(t,plotVals(:,3,2),'Color',c,'LineWidth',lineW);
            end
            p2 = plot(t,plotVals(:,3,2),'Color',c,'LineWidth',lineW);
            plot([t_drug t_drug],[-5 0.5],'--k','LineWidth',1)

            xlim([0 24])
            ylim([-4.1 0])
            yticks([-3 -2 -1 0])
            xticks([0 10 20])
            xlabel('Time (hrs)')
            ylabel('Growth (doublings)')
            xtickangle(0)
            if j > 1 
                axis off
            end
            if i == 9 && j == 10
                legend([p1,p2],'Δ{\itmexZ}','Δ{\itmexZ} microflu.','Location','southoutside')
            end
        end

        
      
        axis off

        if i == 1 && j == 10
            legend('Δ{\itmexZ}','Δ{\itmexZ} mKO','Location','best')

        end
        set(findall(gcf,'-property','FontSize'),'FontSize',fSize)

    end
end

%% Compare resistance profile of KOmexZ to KOmexZ+mKO


hF = figure;
g=1;
for j=1:size(d,2)
    for i=[2 4]
        p=i;
        v=log2(d(:,j,p));

        % Load 3 replicates
        v1 = log2(d(:,j,p));
        v2 = log2(d(:,j,p-1));
        v3 = log2(d(:,j,p+1));

        sigma = zeros(size(v1,1),1);

       
        
        % +- max/min
        v = zeros(size(v1,1),1);
        for k = 1:size(v1,1)
            slice = [v1(k);v2(k);v3(k)];
            distHold = fitdist(slice,'normal');
            sigma(k) = (max(slice)-min(slice))/2;
            v(k) = distHold.mu;
        end


        confInt = [v+sigma v-sigma];
        xconf = [timeVec fliplr(timeVec)];         
        yconf = [confInt(:,1)' fliplr(confInt(:,2)')];

        if i == 2
            subplot(3,size(d,2),j);
            p = fill(xconf,yconf,colMexZ(i/2,:),'FaceColor',colMexZ(i/2,:),'EdgeColor','black','FaceAlpha',0.5);
            hold on
            p21 = plot(timeVec,v,'Color',colMexZ(i/2,:),'LineWidth',1);
        else
            p = fill(xconf,yconf,colMexZ(i/2,:),'FaceColor',colMexZ(i/2,:),'EdgeColor','black','FaceAlpha',0.5);
            p22 = plot(timeVec,v,'Color',colMexZ(i/2,:),'LineWidth',1);
            p24 = plot([time_drug time_drug],[-5 1],'--k','LineWidth',1);
        end

        xlim([0 24])
        ylim([-4.1 0])
        yticks([-3 -2 -1 0])
        xticks([0 10 20])
        xlabel('Time (hrs)','FontSize',14)
        ylabel('Growth (doublings)','FontSize',14)
        ax = gca; 
        ax.FontSize = 14; 
        xtickangle(0)
        th = title(['Spec: ',num2str(drugMexZ(j)),' µg/mL'],'FontWeight','Normal','FontSize',10);
        if j > 1 
            axis off
            th = title([num2str(drugMexZ(j)),' µg/mL'],'FontWeight','Normal','FontSize',10);
        end
        axis off

        % get the position of the title
        titlePos = get( th , 'position');
        % Raise title
        titlePos(2) = titlePos(2)+0.4;
        % update the position
        set( th , 'position' , titlePos);
        
        if j == 577
            g=g+1;
        end
        if i == 4 && j == 10
            legend([p21,p22],'Δ{\itmexZ}','Δ{\itmexZ} mKO','Location','northeast','Orientation','vertical','FontSize',16)
        end
    end
end





