%  DUP   Diagonal Upsampling
% 
% 	y = dup(x, step, [phase])
% 
%  Input:
% 	x:	input image
% 	step:	upsampling factors for each dimension which should be a
% 		2-vector
% 	phase:	[optional] to specify the phase of the input image which
% 		should be less than step, (default is [0, 0])
% 		If phase == 'minimum', a minimum size of upsampled image
% 		is returned
% 
%  Output:
% 	y:	diagonal upsampled image
% 
%  See also:	DDOWN
%