% r = parallelBayes(TRN,TST,li,distributionNames,width,kernel,prior) train a Bayes classifier and return its 
% hyperparameters & performance.
% 
%  A row vector of TRN/TST represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  r is {distributionNames, width, kernel, prior,vauc,tauc}.
%  You must specify that at least one predictor has distribution 'kernel' to additionally specify the parameters of Kernel, 
%  Support, or Width.
%