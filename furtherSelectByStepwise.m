function stepindices = furtherSelectByStepwise(TRN,labels)
%
%indices = furtherSelectByStepwise(TRN,labels)
% If label is [1 2], then class 1 is positive (success) class and class 2 is negative (failure) class.

if max(labels) == 2
  labels(labels == 2) = 0;
end

warning('off');
% modelspace in stepwiseglm specifies the starting model not the final model. Generally, the modelspec of the fine model is linear.
mdl = stepwiseglm(TRN,labels,'constant','Distribution','binomial','Link','logit',...
    'NSteps',200,'Verbose',1,'Criterion','Deviance'); % 'Deviance' (default) | 'sse' | 'aic' | 'bic' | 'rsquared' | 'adjrsquared'
stepindices = mdl2subset(mdl);
end

function subset = mdl2subset(mdl)
subset = zeros(1,length(mdl.PredictorNames));
for i=1:length(subset)
  subset(i) = str2double(replace(mdl.PredictorNames{i},'x',''));
end
end