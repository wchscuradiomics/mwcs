% Extract 11 GLRLM fetures from a run-length matrix. There is no influence if C contains NaN values,
% but the nan values must be in 4 corners.
% f = extractSubbandGlrlmFeatures(C,edges,sequence,nLevels,limits,averaged)
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
%  averaged: a bool value representing 4 directions whether averaged.
% 
%  f: a row vector representing the extracted features.
% 
%  Reference: X. Tang, ÿTexture information in run-length matricesÿ, IEEE Transactions on Image
%  Processing, vol. 7, no. 11, pp. 1602-1609, 1998
%