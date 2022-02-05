% Extract 5 absolute gradient features. There is no influence if C contains NaN values.
% 
%  C: an image (or subimage/coefficient matrix) that will be discretized into the parameter sequence
%  accroding the parameter edges.
% 
%  edges: a row vector representing the discretization edges. If the parameter edges is empty, the
%  discretization will not be performed (C is already a discretized matrix).
% 
%  sequence: a vector listing the values of the discretized elements of C. 
% 
%  f: a row vector representing the extracted features.
%