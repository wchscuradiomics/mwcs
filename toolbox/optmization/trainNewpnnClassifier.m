% Train a binary classifier using newpnn (MATLAB WAY).
% [trainedClassifier, validationResult] = trainNewpnnClassifier(DS,labels,cvp,spread,isFoldResultNeeded)
% 
%  A row vector of DS represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  validationResult.auc: AUC.
%  validationResult.tprates: true positive rates for varied thresholds, descending on vertical axis.
%  validationResult.fprates: false positive rates for varied thresholds, descendding on horizental axis.
%  validationResult.vrs: validation results for k-folders.
% 
%  Wasserman, P.D., Advanced Methods in Neural Computing, New York, Van Nostrand Reinhold, 1993, pp. 35ÿ55
%