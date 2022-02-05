%  PPREC   Parallelogram Polyphase Reconstruction
% 
%  	x = pprec(p0, p1, type)
% 
%  Input:
% 	p0, p1:	two parallelogram polyphase components of the image
% 	type:	one of {1, 2, 3, 4} for selecting sampling matrices:
% 			P1 = [2, 0; 1, 1]
% 			P2 = [2, 0; -1, 1]
% 			P3 = [1, 1; 0, 2]
% 			P4 = [1, -1; 0, 2]
% 
%  Output:
% 	x:	reconstructed image
% 
%  Note:
% 	These sampling matrices appear in the directional filterbank:
% 		P1 = R1 * Q1
% 		P2 = R2 * Q2
% 		P3 = R3 * Q2
% 		P4 = R4 * Q1
% 	where R's are resampling matrices and Q's are quincunx matrices
% 
% 	Also note that R1 * R2 = R3 * R4 = I so for example,
% 	upsample by R1 is the same with down sample by R2	
% 
%  See also:	PPDEC
%