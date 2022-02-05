% [trainedClassifier, validationResult] = autoOptimizeSvmParameters(DS,labels,cvp,kernelFunction,optimizer,parallel)  
% optimize hyperparemeters of SVM automaticlly.
% 
%  fitcsvm ÿÿÿÿÿÿÿÿ
%  
%    BoxConstraint - fitcsvm ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ [1e-3,1e3]ÿ
%  
%    KernelScale - fitcsvm ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ [1e-3,1e3]ÿ
%  
%    KernelFunction - fitcsvm ÿ 'gaussian'ÿ'linear' ÿ 'polynomial' ÿÿÿÿ
%  
%    PolynomialOrder - fitcsvm ÿ [2,4] ÿÿÿÿÿÿÿÿÿÿ
%  
%    Standardize - fitcsvm ÿ 'true' ÿ 'false' ÿÿÿÿ
% 
%  optimizer: bayesopt | gridsearch | bayesopt | randomsearch
%