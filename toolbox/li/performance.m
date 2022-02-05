% Compute indicators.
% 
%  labels: a column vector of m*1 representing labels of samples, where m is the size of the samples.
% 
%  predictedClasses: classified/predicted (by a machine learning model) classes. It can be set to empty.
% 
%  SCORE: a n*2 matrix representing scores, n is the number of observations, the first column is the
%  scores of positive observations.
% 
%  names: [1 2] | [1 0] | 'ab', a row vector representing class names, the default value is [1 2].
% 
%  r: a structure represening the values of indicators including accuracy, sensitivity, specificity,
%  discriminative power, tprates, fprates, AUC, and so on.
%