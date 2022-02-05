function subset = selectByIlfs(TRN,tralabels,TT,nlim)

if size(TRN,2) <= nlim
  subset = 1:size(TRN,2);
  return;
end

[RANKED, ~] = ILFS(TRN, tralabels , TT);
% bar(WEIGHT(RANKED));

subset = RANKED(1:nlim);

% function [TRN,TST,indices] = selectByIlfs(d,kv,traindices,valindices,labels,TT,nlim)
% 
% kv = cell2mat(kv);
% 
% [trakv,mu,sigma] = zscore(kv(traindices));
% sigma(sigma==0) = 1;
% valkv = (kv(valindices)-mu) ./ sigma;
% 
% if nargin == 2
%   TT = 3;
% end
% 
% TRN = d{1};
% TST = d{2};
% 
% if size(TRN,2) <= nlim
%   indices = 1:size(TRN,2);
%   return;
% end
% 
% [RANKED, WEIGHT] = ILFS(TRN, labels , TT);
% bar(WEIGHT(RANKED));
% 
% indices = RANKED(1:nlim);
% 
% TRN = [TRN(:,indices) trakv];
% TST = [TST(:,indices) valkv];