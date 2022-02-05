%  QPREC   Quincunx Polyphase Reconstruction
% 
%  	x = qprec(p0, p1, [type])
% 
%  Input:
% 	p0, p1:	two qunincunx polyphase components of the image
% 	type:	[optional] one of {'1r', '1c', '2r', '2c'}, default is '1r'
% 		'1' and '2' for selecting the quincunx matrices:
% 			Q1 = [1, -1; 1, 1] or Q2 = [1, 1; -1, 1]
% 		'r' and 'c' for suppresing row or column		
% 
%  Output:
% 	x:	reconstructed image
% 
%  Note:
% 	Note that R1 * R2 = R3 * R4 = I so for example,
% 	upsample by R1 is the same with down sample by R2	
%  
%  See also:	QPDEC
%