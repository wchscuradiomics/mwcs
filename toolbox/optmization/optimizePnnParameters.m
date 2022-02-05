% best = optimizePnnParameters(TRN,TST,li,training) optimize hyperparameters for PNN.
% 
%  best is {'radbas',spread,vauc,tauc}.
%  A row vector of TRN/TST represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  training: true (default) or false.
%