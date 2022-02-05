% Extract 5 GLDM features from a differential matrix. There is no influence if C contains NaN values.
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
%  distance: an integer spcifying the differential distance (for example, d = 3 means the
%  distance from 1 to 3) or a vector (for example d = [1 2 3]).
% 
%  averaged: a bool value representing 4 directions whether averaged.
% 
%  f: a row vector representing the extracted features.
% 
%  Note: GLDM features can use contrast and homogeneity due to it count abs(i-j), where i and j are
%  gray-levels. But gray-level histogram can not use contrast and homogeneity due to it just count
%  gray-level i (not "i-j").
%