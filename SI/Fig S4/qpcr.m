data = readmatrix('qPCR Analysis.xlsx','Range','D2:J7');
% Extract fold-change and error bounds
% Assuming 'data' has at least 7 columns and 6 rows as described
fc_WT = data(1:3,5);          % WT fold changes at times 0,3,6
fc_del = data(4:6,5);         % ΔmexZ fold changes at times 0,3,6
ymin_WT = data(1:3,6);
ymax_WT = data(1:3,7);
ymin_del = data(4:6,6);
ymax_del = data(4:6,7);

% X positions (time points)
times = [0 3 6];
nTimes = numel(times);

% Prepare grouped bar data: rows = time points, cols = strains
barData = [fc_WT(:) fc_del(:)];

% Create figure
figure;
hb = bar(times, barData, 'grouped');
hold on;

% Colors for strains
colors = [0 0.4470 0.7410; 0.8500 0.3250 0.0980]; % first row WT, second row ΔmexZ
for k = 1:2
    hb(k).FaceColor = colors(k,:);
end

% Calculate x coordinates for each bar group to place errorbars
% Get x offsets from bar object
x_WT = hb(1).XEndPoints;
x_del = hb(2).XEndPoints;

% Plot errorbars: compute symmetric extents from min/max
err_neg_WT = fc_WT - ymin_WT;
err_pos_WT = ymax_WT - fc_WT;
err_neg_del = fc_del - ymin_del;
err_pos_del = ymax_del - fc_del;

% Use errorbar with asymmetric errors
for i = 1:nTimes
    errorbar(x_WT(i), fc_WT(i), err_neg_WT(i), err_pos_WT(i), 'k', 'LineStyle', 'none', 'LineWidth', 1);
    errorbar(x_del(i), fc_del(i), err_neg_del(i), err_pos_del(i), 'k', 'LineStyle', 'none', 'LineWidth', 1);
end

% Labels and legend
xlabel('Time (hours)');
ylabel('Fold change');
xticks(times);
legend({'WT','\Delta{\itmexZ}'}, 'Location','Best');
box off;
hold off;