%  DFILTERS	Generate directional 2D filters
% 
% 	[h0, h1] = dfilters(fname, type)
% 
%  Input:
%    fname:	Filter name.  Available 'fname' are:
%        'haar':     the "Haar" filters
%        '5-3':      McClellan transformed of 5-3 filters
%        'cd','9-7': McClellan transformed of 9-7 filters (Cohen and Daubechies)
%        'pkvaN':   length N ladder filters by Phong et al. (N = 6, 8, 12)
% 
%    type:	'd' or 'r' for decomposition or reconstruction filters
% 
%  Output:
%    h0, h1:	diamond filter pair (lowpass and highpass)
%