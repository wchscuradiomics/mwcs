function subset = selectFeatureIndicesByLasso(TRN,labels,criteria,cv,alpha,nlim)
%Select feature indices using LASSO.
%subset = selectByLasso(d,labels,criteria,cv,alpha,nlim)
%
% The value alpha = 1 represents lasso regression, Alpha close to 0 approaches ridge regression, and other values represent elastic net optimization.

if nargin == 4
  alpha = 1;
  nlim = 23;
elseif nargin == 5
  nlim = 23;
end

if size(TRN,2) <= 23
  subset = 1:size(TRN,2);
else  
  [B,fitInfo] = lasso(TRN,labels,'CV',cv,'Alpha',alpha ,'Options',statset('UseParallel',true) );%,'UseSubstreams',true
  if strcmpi(criteria,'MSE')
    idxLambdaMinMSE = fitInfo.IndexMinMSE;
    subset = find( B(:,idxLambdaMinMSE)~=0 );
  elseif strcmpi(criteria,'1SE')
    idxLambda1SE = fitInfo.Index1SE;
    subset = find(B(:,idxLambda1SE)~=0);
  else
    error('Invalid criteria!');
  end
end

if length(subset) > nlim
  stepindices = furtherSelectByStepwise(TRN(:,subset),labels);
  subset = subset(stepindices);
end