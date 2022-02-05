function [TRN,TST,subset] = selectBySortedLasso(d,kv,traindices,valindices,labels,criteria,cv,alpha,nlim,threshold)

if nargin ==7
  alpha = 1;
  nlim = 23;
  threshold = 0.18;
elseif nargin == 8 
  nlim = 23;
  threshold = 0.18;
elseif nargin == 9
  threshold = 0.18;
end

kv  =cell2mat(kv);

TRN = d{1};
TST = d{2};

if max(labels) == 2
  labels(labels == 2) = 0;
end

[B,fitInfo] = lasso(TRN,labels,'CV',cv,'Alpha',alpha,'Options',statset('UseParallel',true)); % ,'UseSubstreams',true

if strcmpi(criteria,'MSE')
  [mses,lambdaIndices] = sort(fitInfo.MSE);
else
  [mses,lambdaIndices] = sort(fitInfo.SE);
end

% lambdaIndices = lambdaIndices(mses<=threshold); % 所有的lambda值纳入考察即threshold=1;否则，使用mses<=threshold 
lambdaIndices = lambdaIndices(1:20);

ns = zeros(1,length(lambdaIndices)); % 每个待lambda值 所对应的 被选择的特征数
rfs = zeros(1,length(lambdaIndices));
subsets = cell(1,length(lambdaIndices));

for i=1:length(lambdaIndices)
  ns(i) = sum(B(:,lambdaIndices(i))~=0);
  if ns(i)<=0 
    rfs(i) = -Inf;
    continue;
  end
  
  s = find(B(:,lambdaIndices(i))~=0);
  if length(s) <= nlim
    subsets{i} = s;
    mdl = fitglm(TRN(:,subsets{i}),labels,'Distribution','binomial');    
    rfs(i) = sqrt(mdl.Rsquared.Ordinary);
  else    
    mdl = stepwiseglm(TRN(:,s),labels,'constant','Distribution','binomial','Link','logit',...
      'NSteps',200,'Verbose',0, 'Criterion','adjrsquared'); % 'Criterion' 'Deviance' (default) | 'sse' | 'aic' | 'bic' | 'rsquared' | 'adjrsquared'
    stepSubset = mdl2subset(mdl);
    subsets{i} = s(stepSubset);
    if isempty(stepSubset) % || length(stepSubset) > nlim
      rfs(i)=-Inf;
    else
      % mdl = fitglm(Trn(:,s),responses,'distribution','Binomial','link','logit');
      rfs(i) = sqrt(mdl.Rsquared.Ordinary);
    end
  end
end

[~,I]=sort(rfs,'desc');
lambdaIndex = I(1);

subset = subsets{lambdaIndex};
TRN = [TRN(:,subset) kv(traindices)];
TST = [TST(:,subset) kv(valindices)];
end

function subset = mdl2subset(mdl)
subset = zeros(1,length(mdl.PredictorNames));
for i=1:length(subset)
  subset(i) = str2double(replace(mdl.PredictorNames{i},'x',''));
end
end
