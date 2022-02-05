function subset = selectByLasso(TRN,tralabels,cv,nlim,criteria,alpha,further)
%Select features using LASSO.
%subset = selectByLasso(TRN,tralabels,cv,nlim,criteria,alpha,further)
%
% The value alpha = 1 represents lasso regression, Alpha close to 0 approaches ridge regression, and
% other values represent elastic net optimization.

if nargin == 4
  criteria = 'MSE';
  alpha = 1; 
  further = true;
elseif nargin == 5
  alpha = 1; 
  further = true;
elseif nargin == 6
  further = true;
end

if size(TRN,2) <= nlim
  subset = 1:size(TRN,2);
else  
  [B,fitInfo] = lasso(TRN,tralabels,'CV',cv,'Alpha',alpha); % ,'Options',statset('UseParallel',true));
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

if further
  if length(subset) > nlim
    stepindices = furtherSelectByStepwise(TRN(:,subset),tralabels);
    subset = subset(stepindices);
  end
end