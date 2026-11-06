function ritzStarX(pPairwise,upperY,x,c1,c2)
    yInc1 = 400;
    yInc2 = yInc1/4;
    for q = 1:size(pPairwise,1)
        % Add line for each pairwise comparison
        newY = upperY+yInc1*(q-1);

        line([x(c1(q)) x(c2(q))],[newY newY],'Color','black','LineWidth',1)
        halfPt = (x(c1(q))+x(c2(q)))/2;

        % Draw significance marking for pairwise comparison
        if pPairwise(q) <= 0.001
            text(halfPt,newY+yInc2,'***','FontSize',20,'FontWeight','bold','HorizontalAlignment','center');
        elseif pPairwise(q) <= 0.01
            text(halfPt,newY+yInc2,'**','FontSize',20,'FontWeight','bold','HorizontalAlignment','center');
        elseif pPairwise(q) <= 0.05
            text(halfPt,newY+yInc2,'*','FontSize',20,'FontWeight','bold','HorizontalAlignment','center');
        else
            text(halfPt,newY+yInc2,'n.s.','FontSize',20,'FontWeight','bold','HorizontalAlignment','center');
        end
    end

    % text(2, -yInc1, '*** p < 0.001', 'clipping', 'off','FontSize',10,'FontWeight','normal');
    % text(3.5, -yInc1, '** p < 0.01', 'clipping', 'off','FontSize',10,'FontWeight','normal');
    % text(5, -yInc1, '* p < 0.05', 'clipping', 'off','FontSize',10,'FontWeight','normal');
    
end
