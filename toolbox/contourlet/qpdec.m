%  QPDEC   Quincunx Polyphase Decomposition
% 
%  	[p0, p1] = qpdec(x, [type])
% 
%  Input:
% 	x:	input image
% 	type:	[optional] one of {'1r', '1c', '2r', '2c'} default is '1r'
% 		'1' and '2' for selecting the quincunx matrices:
% 			Q1 = [1, -1; 1, 1] or Q2 = [1, 1; -1, 1]
% 		'r' and 'c' for suppresing row or column		
% 
%  Output:
% 	p0, p1:	two qunincunx polyphase components of the image
%