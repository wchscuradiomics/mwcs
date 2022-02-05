% r = parallelEda(TRN,TST,li,...
%     discrimType,gamma,delta,subspaceDimension,numLearningCycles,prior) train a EDA (ensemble discriminative analysis) 
% classifier and return its hyperparameters & performance.
% 
%  A row vector of TRN/TST represents a sample.
%  If label is [1 2]: label equals to 1 is a positive class; label equals to 2 is a negative class.
%  If label is [1 0]: label equals to 1 is a positive class; label equals to 0 is a negative class.
%  r is {discrimType,gamma,delta,subspaceDimension,numLearningCycles,prior,vauc,tauc}.
%