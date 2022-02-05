function [p,h,stats] = mwu(FeP,FeN,side)

if nargin == 2
  side = 'both';
end

if size(FeP,2) ~= size(FeN,2)
  error 'column number is not equal'
end
p = zeros(1,size(FeP,2));
h = zeros(1,size(FeP,2));
stats = cell(1,size(FeP,2));
for i=1:size(FeP,2)
  [p(i),h(i),stats{i}] = ranksum(FeP(:,i),FeN(:,i),'tail',side);
end