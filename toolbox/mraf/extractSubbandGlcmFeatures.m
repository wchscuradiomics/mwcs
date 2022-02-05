% Extract 23 or 5 GLCM fetures from a co-occurrence matrix. There is no influence if C contains NaN values.
% f=extractSubbandGlcmFeatures(C,edges,sequence,nLevels,limits,distance,averaged,method)
% It first discritizes C based on edges/sequence or nLevels/limits, then scales C into 1:nLevels
% based on nLevels/limits. If edges/sequence is empty, nLevels/limits specifies both the
% discretization and scaling.
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
%  distance: an integer spcifying the distance of co-occurrence matrices. For example, d = 3 means the
%  distance from 1 to 3.
% 
%  averaged: a bool value representing 4 directions whether averaged.
% 
%  method = 'widely-used' or 'all'.
% 
%  f: a row vector representing the extracted features.
% 
%    References [1] Haralick, R.M., K. Shanmugan, and I. Dinstein, "Textural Features for Image
%    Classification", IEEE Transactions on Systems, Man, and Cybernetics, Vol. SMC-3, 1973, pp.
%    610-621.
% 
%    [2] Haralick, R.M., and L.G. Shapiro. Computer and Robot Vision: Vol. 1, Addison-Wesley, 1992,
%    p. 459.
% 
%    [others] refer to the fuction glcmFeatures
% 
%    Notes ----- Another name for a gray-level co-occurrence matrix is a gray-level spatial
%    dependence matrix.
% 
%    GRAYCOMATRIX ignores pixels pairs if either of their values is NaN. It also replaces Inf with
%    the value 'NumLevels' and -Inf with the value 1.
%