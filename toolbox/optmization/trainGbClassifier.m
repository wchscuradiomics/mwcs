% Train a binary classifier using gradient boosting trees (GBT).
% [trainedClassifier, validationResult] = trainGbClassifier(DS,labels,cvp,impMethod,...
% 	maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,splitCriterion,predictorSelection,...
% 	numLearningCycles,learnRate,prior,isFoldResultNeeded)
%  
%  A row vector of DS represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  impMethod is AdaBoostM1, GentleBoost, or LogitBoost.
%  prior: 'empirical' (default) | 'uniform'.
%  validationResult.auc: AUC.
%  validationResult.tprates: true positive rates for varied thresholds, descending on vertical axis.
%  validationResult.fprates: false positive rates for varied thresholds, descendding on horizental axis.
%  validationResult.vrs: validation results for k-folders.
%