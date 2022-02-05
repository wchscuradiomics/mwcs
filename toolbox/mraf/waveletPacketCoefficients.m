% Calculate wavelet packet coefficient matrices
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
%  COEFFS: a n*m cell, m is the number of compoments for an ROI. COEFFS{i,1} is the original image of
%  ROIS{i}, COEFFS{i,[2,6,22]} are approximations of ROIS{i}
%