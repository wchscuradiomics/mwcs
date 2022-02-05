%  FBDEC   Two-channel 2D Filterbank Decomposition
% 
% 	[y0, y1] = fbdec(x, h0, h1, type1, type2, [extmod])
% 
%  Input:
% 	x:	input image
% 	h0, h1:	two decomposition 2D filters
% 	type1:	'q', 'p' or 'pq' for selecting quincunx or parallelogram
% 		downsampling matrix
% 	type2:	second parameter for selecting the filterbank type
% 		If type1 == 'q' then type2 is one of {'1r', '1c', '2r', '2c'}
% 		If type1 == 'p' then type2 is one of {1, 2, 3, 4}
% 			Those are specified in QDOWN and PDOWN
% 		If type1 == 'pq' then same as 'p' except that
% 		the paralellogram matrix is replaced by a combination 
% 		of a  resampling and a quincunx matrices
% 	extmod:	[optional] extension mode (default is 'per')
% 
%  Output:
% 	y0, y1:	two result subband images
% 
%  Note:		This is the general implementation of 2D two-channel
%  		filterbank
% 
%  See also:	FBDEC_SP
%