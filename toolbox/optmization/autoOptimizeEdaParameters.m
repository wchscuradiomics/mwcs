% [trainedClassifier, validationResult] = autoOptimizeEdaParameters(DS,labels,cvp,optimizer,parallel)  
% optimize hyperparemeters of EDA (ensemble of discriminative analysis) automaticlly.
% 
%  The eligible hyperparameters for EDA are:
% 
%    NumLearningCycles ÿ fitcensemble searches among positive integers, by default log-scaled with range [10,500].
% 
%    Delta	Log-scaled in the range [1e-6,1e3].
% 
%    DiscrimType	'linear', 'quadratic', 'diagLinear', 'diagQuadratic', 'pseudoLinear', and 'pseudoQuadratic'.
% 
%    Gamma	Real values in [0,1].
% 
%  optimizer: bayesopt | gridsearch | bayesopt | randomsearch
%