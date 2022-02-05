%  DFBDEC   Directional Filterbank Decomposition
% 
% 	y = dfbdec(x, fname, n)
% 
%  Input:
%    x:      input image
%    fname:  filter name to be called by DFILTERS
%    n:      number of decomposition tree levels
% 
%  Output:
%    y:	    subband images in a cell vector of length 2^n
% 
%  Note:
%    This is the general version that works with any FIR filters
%       
%  See also: DFBREC, FBDEC, DFILTERS
%