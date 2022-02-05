function ci = calci(means,stds,n,confidenceLevel)

if nargin == 3
  confidenceLevel = 0.05;
end

if size(means,1) ~= size(stds,1) || size(means,2) > 1 || size(stds,2) > 1
  error('means and stds must be column vectors and the number of means must equal to the number of stds.');
end

if confidenceLevel == 0.05
  zh = 1.96;
elseif confidenceLevel== 0.01
  zh = 2.576;
end

% m = round(m,4);
% s = round(s,4);

ci = zeros(size(means,1),2);
ci(:,1) = means-zh*(stds./sqrt(n));
ci(:,2) = means+zh*(stds./sqrt(n));