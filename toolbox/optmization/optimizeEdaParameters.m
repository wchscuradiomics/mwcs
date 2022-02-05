% best = optimizeEdaParameters(TRN,TST,li,type,prior,training,seed) optimize hyperparameters for Ensemble Discriminative Analysis.
%  
%  best is {discrimType,gamma,delta,subspaceDimension,numLearningCycles,prior,vauc,tauc}.
%  A row vector of TRN/TST represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  type: linear or quadratic.
%  training: true (default) or false.
%