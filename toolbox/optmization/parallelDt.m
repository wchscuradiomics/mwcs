% function r = parallelDt(TRN,TST,li,...
%   maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,splitCriterion,predictorSelection,prior) train a DT
%   classifier and return its hyperparameters & performance.
% 
%  A row vector of TRN/TST represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  r is {maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,splitCriterion,predictorSelection,prior,vauc,tauc}.
%