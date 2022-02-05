% Randomly divide a dataset into a training set and a validation set. The validation set can be used
% as an individual test/validation set.
% [traindices,valindices,tralabels,vallabels]=divideDataset(labels,rate,names)
% 
%  labels: a column vector representing labels of samples.
% 
%  rate: a number representing the rate of the training set.
% 
%  names: a vector or string ([1 0] or  [1 2] or 'ab').
% 
%  traindices: indices of the training set.
% 
%  valindices: indices of the validation set.
% 
%  tralabels: labels of the training set.
% 
%  vallabels: labels of the validation set.
%