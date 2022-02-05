% Train a binary classifier using ANN.
% [trainedClassifier, validationResult,tr] = trainAnnClassifier(DS,labels,cvp,...
%   holdout,hiddenLayers,trainFcn,performFcn,isFoldResultNeeded)
% 
%  A row vector of DS represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  validationResult.auc: AUC.
%  validationResult.tprates: true positive rates for varied thresholds, descending on vertical axis.
%  validationResult.fprates: false positive rates for varied thresholds, descendding on horizental axis.
%  validationResult.vrs: validation results for k-folders.
% 
%  holdout = cvpartition(labels,'Holdout',0.3);
%