%  DFBREC_L   Directional Filterbank Reconstruction using Ladder Structure
% 
% 	x = dfbrec_l(y, fname)
% 
%  Input:
% 	y:	subband images in a cell vector of length 2^n
% 	f:	filter in the ladder network structure,
% 		can be a string naming a standard filter (see LDFILTER)
% 
%  Output:
% 	x:	reconstructed image
% 
%  See also:	DFBDEC, FBREC, DFILTERS
%