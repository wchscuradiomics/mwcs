%  PFILTERS    Generate filters for the Laplacian pyramid
% 
% 	[h, g] = pfilters(fname)
% 
%  Input:
% 	fname:	Name of the filters, including the famous '9-7' filters
% 		    and all other available from WFILTERS in Wavelet toolbox
% 
%  Output:
% 	h, g:	1D filters (lowpass for analysis and synthesis, respectively)
% 		    for seperable pyramid
%