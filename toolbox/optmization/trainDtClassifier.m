% Train a binary classifier using decision tree.
% [trainedClassifier, validationResult] = trainDtClassifier(DS, labels, cvp, maxNumSplits, minLeafSize, ...
%  minParentSize, numVariablesToSample, splitCriterion, predictorSelection, prior, isFoldResultNeeded)
% 
%  A row vector of DS represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  prior: 'empirical' (default) | 'uniform'.
%  validationResult.auc: AUC.
%  validationResult.tprates: true positive rates for varied thresholds, descending on vertical axis.
%  validationResult.fprates: false positive rates for varied thresholds, descendding on horizental axis.
%  validationResult.vrs: validation results for k-folders.
% 
%  A smaller maxNumSplits value means a coarser tree.
%  When the sample sizes are unbalanced, adjust 'Cost' parameter (a n*n matrix, where n is number of classes), the
%  default is Cost(i,j)=1 if i~=j, and Cost(i,j)=0 if i=j.
%