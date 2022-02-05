% Compute true positive rates and false positive rates. A row vector is an observation.
% 
%  S: a n*2 matrix representing scores, n is the number of observations, the first column is the
%  scores of positive observations.
% 
%  labels: is a column vector representing labels, value 1 is positive and value 2 is negative.
% 
%  intervals: a row vector, the sizes of tprates and fprates are both the same as inv.
% 
%  names: [1 2] | [1 0] | 'ab', a row vector representing class names, the default value is [1 2]. names(1) is the positive
%  class.
% 
%  tprates: a row vector representing true positive rates.
% 
%  fprates: a row vector representing false posiive rates.
%