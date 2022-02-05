%  QDOWN   Quincunx Downsampling
% 
%  	y = qdown(x, [type], [extmod], [phase])
% 
%  Input:
% 	x:	input image
% 	type:	[optional] one of {'1r', '1c', '2r', '2c'} (default is '1r')
% 		'1' or '2' for selecting the quincunx matrices:
% 			Q1 = [1, -1; 1, 1] or Q2 = [1, 1; -1, 1] 
% 		'r' or 'c' for suppresing row or column		
% 	phase:	[optional] 0 or 1 for keeping the zero- or one-polyphase
% 		component, (default is 0)
% 
%  Output:
% 	y:	qunincunx downsampled image
% 
%  See also:	QPDEC
%