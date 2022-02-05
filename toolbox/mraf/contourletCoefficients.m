% Compute contourlet coefficient matrices.
% COEFFS = contourletCoefficients(ROIS,levels,divisor,minEdge,pfilter,dfilter,interpolation,integer,limits,pmode)
% 
%  ROIS: a n*1 cell specifying n samples.
% 
%  levels: a row vector specifying the decomposition levels, for example levels = [2 3] means 2^2
%  components in the second-level decomposition and 2^3 components in the first-level decomposition.
% 
%  divisor: an integer specifying the multiple of the height and width of an ROI, the default value
%  is 4.
% 
%  minEdge: an integer specifying the minimum width or height of an ROI. If the width or height of
%  an ROI < minWidth, interpolation will be used.
% 
%  pfilter: Pyramidal filter, the default value is '9-7'.
% 
%  dfilter: Directional filter, the default value is 'pkva6'.
% 
%  interpolation: 'nearest','bilinear', or 'bicubic', where 'bicubic' is the dafault value.
% 
%  dataType: a string (integer from [limits(1) limits(2)] or norm to [0 1]) specifying whether to round after interpolation.
% 
%  COEFFS: a n*m cell of coefficient matrices, where n is the sample sizeand a row vector contains m
%  coefficient matrices for a sample.
% 
%  Note: In TMI-2020-0838, the i-th ROI (no decomposition performed) was used as COEFFS{i,1};
%  However, the revised function does not do this anymore.
%