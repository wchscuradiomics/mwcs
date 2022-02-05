% Optimize Logistic Regression hyperparameters.
% best = optimizeLrParameters(TRN,TST,li,distribution,training)
% 
%  best is {distribution,link,modelspec,binomialSize,vauc,tauc}.
%  A row vector of TRN/TST represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  training: true (default) or false.
%  distribution: 'normal','binomial','poisson','gamma','inverse gaussian'
%