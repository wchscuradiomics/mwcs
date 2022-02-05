% Calculate wavelet coeffient matrices.
% COEFFS = waveletCoefficients(ROIS,waveletName,level,interpolation,minWidth,integer)
% 
%  ROIS: a n*1 cell, where ROIS{i} is a matrix representing the i-th ROI.
% 
%  level: an integer specifying the decomposition level of wavelet transform.
% 
%  interpolation: a char vector, its value can be 'nearest','bilinear', or 'bicubic', 'bicubic' is
%  the dafault value.
% 
%  minEdge: an integer specifying the minimum width/height of an ROI.
% 
%  dataType: a string (integer from [limits(1) limits(2)] or norm to [0 1]) specifying whether to round after interpolation.
% 
%  COEFFS: a n*m cell, m is the number of compoments for an ROI. COEFFS{i,1} is
%  approximations of ROIS{i}.
% 
%  Note: In TMI-2020-0838, the i-th ROI (no decomposition performed) was used as COEFFS{i,1};
%  However, the revised function does not do this anymore.
%