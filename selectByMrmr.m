function subset = selectByMrmr(TRN,traindices,nlim)

if size(TRN,2) <= nlim
  subset = 1:size(TRN,2);
  return;
end

[idx,~] = fscmrmr(TRN, traindices);
subset = idx(1:nlim);

% function [TRN,TST,indices] = selectByMrmr(d,kv,traindices,valindices,labels,nlim)

% kv = cell2mat(kv);
% 
% [trakv,mu,sigma] = zscore(kv(traindices));
% sigma(sigma==0) = 1;
% valkv = (kv(valindices)-mu) ./ sigma;
% 
% TRN = d{1};
% TST = d{2};
% 
% if size(TRN,2) <= 23
%   indices = 1:size(TRN,2);
%   return;
% end
% 
% [idx,scores] = fscmrmr(TRN, labels);
% bar(scores(idx));
% 
% indices = idx(1:nlim);
% 
% TRN = [TRN(:,indices) trakv];
% TST = [TST(:,indices) valkv];