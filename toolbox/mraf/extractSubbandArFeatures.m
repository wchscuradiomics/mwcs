% Extract 5 autogression features. There is no influence if C contains NaN values.
% f = extractSubbandArFeatures(C,edges,sequence,nLevels,limits,method)
% 
%  C: an image (or subimage/coefficient matrix) that will be discretized into the parameter sequence
%  accroding the parameter edges.
% 
%  edges: a row vector representing the discretization edges. If the parameter edges is empty, the
%  discretization is based on nLevels/limits.
% 
%  sequence: a vector listing the values of the discretized elements of C. 
% 
%  nLevels: an integer specifying the scaled number of levels for the discretized C.
% 
%  limits: [limits(1) limits(2)] specifying the limiting range when including scaling the discretized C.
% 
%  f: a row vector representing the extracted features.
%