%  DFBDEC_L   Directional Filterbank Decomposition using Ladder Structure
% 
% 	y = dfbdec_l(x, f, n)
% 
%  Input:
% 	x:	input image
% 	f:	filter in the ladder network structure,
% 		can be a string naming a standard filter (see LDFILTER)
% 	n:	number of decomposition tree levels
% 
%  Output:
% 	y:	subband images in a cell array (of size 2^n x 1)
%