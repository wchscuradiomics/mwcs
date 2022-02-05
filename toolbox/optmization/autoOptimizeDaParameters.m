% [trainedClassifier, validationResult] = autoOptimizeDaParameters(DS,labels,cvp,optimizer,parallel)  
% optimize hyperparemeters of DA automaticlly.
% 
%  The eligible parameters for fitcdiscr are:
%  
%    Delta � fitcdiscr searches among positive values, by default log-scaled in the range [1e-6,1e3].
%  
%    DiscrimType � fitcdiscr searches among 'linear', 'quadratic', 'diagLinear', 'diagQuadratic', 'pseudoLinear', and
%    'pseudoQuadratic'.
%  
%    Gamma � fitcdiscr searches among real values in the range [0,1]
% 
%  optimizer: bayesopt | gridsearch | bayesopt | randomsearch
%