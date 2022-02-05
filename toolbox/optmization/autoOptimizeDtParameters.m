% [trainedClassifier, validationResult] = autoOptimizeDtParameters(DS,labels,cvp,optimizer) optimize hyperparameters of 
% dicision trees %automaticlly.
% 
%  hyperparameters: all. The eligible parameters for fitctree are:
% 
%    MaxNumSplits � fitctree searches among integers, by default log-scaled in the range [1,max(2,NumObservations-1)].
% 
%    MinLeafSize � fitctree searches among integers, by default log-scaled in the range [1, max(2,
%    floor(NumObservations/2))].
% 
%    SplitCriterion � For two classes, fitctree searches among 'gdi' and 'deviance'. For three or more classes, fitctree
%    also searches among 'twoing'.
% 
%    NumVariablesToSample � fitctree does not optimize over this hyperparameter. If you pass NumVariablesToSample as a
%    parameter name, fitctree simply uses the full number of predictors. However, fitcensemble does optimize over this
%    hyperparameter.
% 
%  optimizer: bayesopt | gridsearch | bayesopt | randomsearch
%