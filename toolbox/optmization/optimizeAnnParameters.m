% [best1,best2] = optimizeAnnParameters(TRN,TST,li,training) optimize hyperparameters for ANN. best1 for non-trainbr and
% best2 for trainbr.
% 
%  best is {hiddenLayers,trainFcn,performFcn,vauc,tauc}.
%  A row vector of TRN/TST represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  type: linear or quadratic
%  prior: 'empirical' (default) | 'uniform'.
%  training: true (default) or false.
%