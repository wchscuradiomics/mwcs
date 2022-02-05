%  FBREC   Two-channel 2D Filterbank Reconstruction
% 
% 	x = fbrec(y0, y1, h0, h1, type1, type2, [extmod])
% 
%  Input:
% 	y0, y1:	two input subband images
% 	h0, h1:	two reconstruction 2D filters
% 	type1:	'q', 'p' or 'pq' for selecting quincunx or parallelogram
% 		upsampling matrix
% 	type2:	second parameter for selecting the filterbank type
% 		If type1 == 'q' then type2 is one of {'1r', '1c', '2r', '2c'}
% 		If type1 == 'p' then type2 is one of {1, 2, 3, 4}
% 			Those are specified in QUP and PUP
% 		If type1 == 'pq' then same as 'p' except that
% 		the paralellogram matrix is replaced by a combination 
% 		of a quincunx and a resampling matrices
% 	extmod:	[optional] extension mode (default is 'per')
% 
%  Output:
% 	x:	reconstructed image
% 
%  Note:	This is the general case of 2D two-channel filterbank
% 
%  See also:	FBDEC
%