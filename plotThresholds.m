function plotThresholds(thresholds, accs, sens, specs,xlimits,titleString)

if nargin == 5, titleString=[]; end

% [x,y] = polyline2curve(thresholds,accs);
plot(thresholds,accs,'b-.','LineWidth',0.5);
% [x,y] = polyline2curve(thresholds,sens);
hold on, plot(thresholds, sens,'r-', 'LineWidth',1.5);
hold on, plot(thresholds, specs,'g:','LineWidth',1);
legend({'Accuracy','Sensitivity (True Positive Rate)','Specificity (True Negative Rate)'},'EdgeColor','w',...
  'Location','SouthEast','Position',[0.5,0.2,0.3,0.225]);
xlabel('Horizontal Axis: Threshold','Position',[mean(xlimits) 0.06 -1]);
ylabel('Vertical Axis: Indicator Value','Position',[xlimits(1)+0.02 0.27 -1]);
% xticks(0:0.05:1)
xlim(xlimits);
ylim([0 1]);

if ~isempty(titleString)
  title(titleString,'Position',[mean(xlimits),0.89,0]);
end

end

% function [x,y] = polyline2curve(x,y)
% y = y';
% values = spcrv([[x(1) x x(end)];[y(1) y y(end)]],3);
% x = values(1,:);
% y = values(2,:);
% end