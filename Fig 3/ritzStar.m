function newY = ritzStar(comparisons,pPairwise,upperY)
    yInc1 = upperY/10;
    yInc2 = yInc1/2.5;
    xCorrect = 0;
    for q = 1:size(comparisons,1)
        % Add line for each pairwise comparison
        newY = upperY+yInc1*q-upperY/40;

        % x-values slightly off
        line([comparisons(q,1) comparisons(q,2)],[newY newY],'Color','black','LineWidth',2)
        halfPt = sum(comparisons(q,:))/2-xCorrect;

        % Draw significance marking for pairwise comparison
        if pPairwise(q) <= 0.001
            text(halfPt,newY+yInc2-upperY/40,'***','FontSize',30,'FontWeight','bold','HorizontalAlignment','center');
        elseif pPairwise(q) <= 0.01
            text(halfPt,newY+yInc2-upperY/40,'**','FontSize',30,'FontWeight','bold','HorizontalAlignment','center');
        elseif pPairwise(q) <= 0.05
            text(halfPt,newY+yInc2-upperY/40,'*','FontSize',30,'FontWeight','bold','HorizontalAlignment','center');
        else
            text(halfPt,newY+yInc2*1.5,'n.s.','FontSize',30,'FontWeight','bold','HorizontalAlignment','center');
        end
    end
    
end
