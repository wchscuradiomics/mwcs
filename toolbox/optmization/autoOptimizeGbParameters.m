% [trainedClassifier, validationResult] = autoOptimizeGbParameters(DS,labels,cvp,method,optimizer,parallel,seed) 
% optimize hyperparemeters of EDA (ensemble of discriminative analysis) automaticlly
% 
%  A row vector represents a sample.
%  The eligible hyperparameters for the chosen Learners:
% 
%    NumLearningCycles ÿ fitcensemble searches among positive integers, by default log-scaled with range [10,500].
%  
%    LearnRate ÿ fitcensemble searches among positive reals, by default log-scaled with range [1e-3,1].
% 
%    MaxNumSplits	Integers log-scaled in the range [1,max(2,NumObservations-1)].
% 
%    MinLeafSize	Integers log-scaled in the range [1,max(2,floor(NumObservations/2))].
% 
%    NumVariablesToSample	Integers in the range [1,max(2,NumPredictors)]
% 
%    SplitCriterion	'gdi', 'deviance', and 'twoing'
% 
%  method: GentleBoost | LogitBoost | AdaBoostM1 | RUSBoost
% 
%  optimizer: bayesopt | gridsearch | bayesopt | randomsearch
% 
%  If method is 'bag', the training uses the way of random forest (See autoOptimizeRfParameters).
%  For three or more classes, eligible methods are 'Bag', 'AdaBoostM2', and 'RUSBoost'.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%