% Compute MRA features of n samples. The j-th coefficient matrix of an ROI is discretized into
% parameter.sequences{j} (a row vector) basing parameter.starts(j) and parameter.steps(j).
% 
%  COEFFS: a n*m cell, where m is the number of components for an ROI.
% 
%  parameter.grayscales is a 1*m vector representing grayscales, where parameter.grayscales(j) = x
%  means the grayscale of the j-th component is [1,x].
% 
%  parameter.starts is a 1*m vector representing start points, where parameter.starts(j) corresponds
%  to the j-th component.
% 
%  parameter.steps is a 1*m vector representing steps of the start points, where parameter.steps(j)
%  corresponds to the j-th component.
% 
%  parameter.sequences is a 1*m cell representing the discretized values of discretized components,
% 
%  parameter.sequences{j} = [1,8,16] means the discretized values of the j-th component (a
%  subinterval of [1 n{j}]) can only be 1, 8, or 16.
% 
%  As for a coefficient matrix belongs to the j-th component, this algorithm first discretes the
%  coefficient matrix, sequences{j} specifies the discreted values (it is a subinterval of [1
%  parameters.grayscales(j)]), then calculates texture features of this  discreted coefficient matrix
%  (equally, the grayscale of the subimage is [1 parameters.grayscales(j)]).
% 
%  F: a n*f matrix representing the features of COEFFS, there are f features extracted from
%  COEFFS(i,:). 
% 
%  Note: starts of approximations cannot be zeros and must be calculated on mins of the
%  approximation self or average minis of approximations.
%