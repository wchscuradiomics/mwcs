%  RESAMPZ   Resampling of matrix
% 
%        y = resampz(x, type, [shift])
% 
%  Input:
%        x:      input matrix
%        type:   one of {1, 2, 3, 4} (see note)
%        shift:  [optional] amount of shift (default is 1)
% 
%  Output:
%        y:      resampled matrix
% 
%  Note:
% 	The resampling matrices are:
% 		R1 = [1, 1;  0, 1];
% 		R2 = [1, -1; 0, 1];
% 		R3 = [1, 0;  1, 1];
% 		R4 = [1, 0; -1, 1];
% 
% 	This resampling program does NOT involve periodicity, thus it
% 	zero-pad and extend the matrix
% 
%  See also:	RESAMP
%