function ritzStarY(pPairwise,upperX,x,c1,c2)
    xInc1 = -150;
    xInc2 = xInc1/6;
    for q = 1:size(pPairwise,1)
        % Add line for each pairwise comparison
        newX = upperX+xInc1*(q-1);
        
        line([newX newX],[x(c1(q)) x(c2(q))],'Color','black','LineWidth',1)
        halfPt = (x(c1(q))+x(c2(q)))/2;

        % Draw significance marking for pairwise comparison
        if pPairwise(q) <= 0.001
            text(newX+xInc2,halfPt,'***','FontSize',20,'FontWeight','bold','HorizontalAlignment','center','Rotation',90);
        elseif pPairwise(q) <= 0.01
            text(newX+xInc2,halfPt,'**','FontSize',20,'FontWeight','bold','HorizontalAlignment','center','Rotation',90);
        elseif pPairwise(q) <= 0.05
            text(newX+xInc2,halfPt,'*','FontSize',20,'FontWeight','bold','HorizontalAlignment','center','Rotation',90);
        else
            text(newX+xInc2-30,halfPt,'n.s.','FontSize',20,'FontWeight','bold','HorizontalAlignment','center','Rotation',90);
        end
    end
    
end
