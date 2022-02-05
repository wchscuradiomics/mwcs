%  PDOWN   Parallelogram Downsampling
% 
%  	y = pdown(x, type, [phase])
% 
%  Input:
% 	x:	input image
% 	type:	one of {1, 2, 3, 4} for selecting sampling matrices:
% 			P1 = [2, 0; 1, 1]
% 			P2 = [2, 0; -1, 1]
% 			P3 = [1, 1; 0, 2]
% 			P4 = [1, -1; 0, 2]
% 	phase:	[optional] 0 or 1 for keeping the zero- or one-polyphase
% 		component, (default is 0)
% 
%  Output:
% 	y:	parallelogram downsampled image
% 
%  Note:
% 	These sampling matrices appear in the directional filterbank:
% 		P1 = R1 * Q1
% 		P2 = R2 * Q2
% 		P3 = R3 * Q2
% 		P4 = R4 * Q1
% 	where R's are resampling matrices and Q's are quincunx matrices
% 
%  See also:	PPDEC
%