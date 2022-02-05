% Extract histogram of oriented gradients (HOG) features.
% 
%  C: an image (or subimage/coefficient matrix) that will be discretized into the parameter sequence
%  accroding the parameter edges.
% 
%  edges: a row vector representing the discretization edges. If the parameter edges is empty, no
%  discretization on C (the grayscale range of C is already [1 nLevels]).
% 
%  sequence: a vector listing the values of the discretized elements of C.
% 
%  cs: a 1*2 vector specifying the size of HOG cell.
% 
%  nBins: an integer specifying the number of orientation histogram bins.
% 
%  isUseSignedOrientation: a logical scalar specifying the selection of orientation values.
% 
%  f: a row vector representing the extracted features.
%