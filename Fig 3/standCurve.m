function odPerFlu = standCurve(fname)

    % Load standard curve data
    dat = readtable(fname,'Sheet','KOmexZ_mono'); 

    x = table2array(dat(:,3));
    y = table2array(dat(:,2));

    % straight part of mKO vs OD curve
    idx1 = find(x > 0.05,1);
    idx2 = find(x > 0.42,1);
    
    x = x(idx1:idx2);
    y = y(idx1:idx2);
    
    fitSlope = polyfit(x,y,1);
    odPerFlu = 1/fitSlope(1);

end
