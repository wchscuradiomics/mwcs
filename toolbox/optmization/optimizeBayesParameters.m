% best = optimizeBayesParameters(TRN,TST,li,prior,training) optimize hyperparameters for Bayes.
% 
%  best is {distributionNames, width, kernel, prior,vauc,tauc};.
%  A row vector of TRN/TST represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  type: linear or quadratic
%  prior: 'empirical' (default) | 'uniform'.
%  training: true (default) or false.
%  prior: empirical (default) | uniform | numeric vector
%