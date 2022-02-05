% best = optimizeGbParameters(TRN,TST,li,imp,prior,training,seed) optimize hyperparameters for Grading Boost Trees.
%  
%  best is r =  {impMethod,maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,...
%   splitCriterion,predictorSelection,numLearningCycles,learnRate,prior,vauc,tauc}.
%  A row vector of TRN/TST represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  impMethod is AdaBoostM1, GentleBoost, or LogitBoost.
%  prior: 'empirical' (default) | 'uniform'.
%  training: true (default) or false.
%