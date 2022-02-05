%  QUPZ   Quincunx Upsampling (with zero-pad and matrix extending)
% 
%  	y = qup(x, [type])
% 
%  Input:
% 	x:	input image
% 	type:	[optional] 1 or 2 for selecting the quincunx matrices:
% 			Q1 = [1, -1; 1, 1] or Q2 = [1, 1; -1, 1]
%  Output:
% 	y:	qunincunx upsampled image
% 
%        This resampling operation does NOT involve periodicity, thus it
%        zero-pad and extend the matrix
%