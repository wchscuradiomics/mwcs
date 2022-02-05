% [trainedClassifier, validationResult] = autoOptimizeBayesParameters(DS,labels,cvp,optimizer) optimize hyperparameters of 
% Bayes automaticlly.
% 
%  The eligible parameters for fitcnb are:
%  
%    DistributionNames � fitcnb searches among 'normal' and 'kernel'.
%  
%    Width � fitcnb searches among real values, by default log-scaled in the range [MinPredictorDiff/4,
%    max(MaxPredictorRange,MinPredictorDiff)].
%  
%    Kernel � fitcnb searches among 'normal', 'box', 'epanechnikov', and 'triangle'.
% 
%  optimizer: bayesopt | gridsearch | bayesopt | randomsearch
%