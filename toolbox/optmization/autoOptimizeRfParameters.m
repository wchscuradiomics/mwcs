% [trainedClassifier, validationResult] = autoOptimizeRfParameters(DS,labels,cvp,optimizer,parallel) optimize 
% hyperparemeters of Random Forest automaticlly.
% 
%  hyperparameters: all. The eligible parameters for fitctree are:
% 
%    MaxNumSplits ÿ fitctree searches among integers, by default log-scaled in the range [1,max(2,NumObservations-1)].
% 
%    MinLeafSize ÿ fitctree searches among integers, by default log-scaled in the range [1, max(2,
%    floor(NumObservations/2))].
% 
%    SplitCriterion ÿ For two classes, fitctree searches among 'gdi' and 'deviance'. For three or more classes, fitctree
%    also searches among 'twoing'.
% 
%    NumVariablesToSample ÿ fitctree does not optimize over this hyperparameter. If you pass NumVariablesToSample as a
%    parameter name, fitctree simply uses the full number of predictors. However, fitcensemble does optimize over this
%    hyperparameter.
% 
%    NumLearningCycles ÿ fitcensemble searches among positive integers, by default log-scaled with range [10,500].
% 
%  optimizer: bayesopt | gridsearch | bayesopt | randomsearch
%