% Train binary a classifier using discriminant analysis.
% [trainedClassifier, validationResult] = trainDaClassifier(DS,labels,cvp,discrimType,gamma,delta,prior,isFoldResultNeeded)
% 
%  A row vector of DS represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  discrimType: 'linear' (default) | 'quadratic' | 'diaglinear' | 'diagquadratic' | 'pseudolinear' | 'pseudoquadratic'
%  delta: must be 0 for quadratic discriminant models.
%  prior: 'empirical' (default) | 'uniform' | vector of scalar values | structure
%