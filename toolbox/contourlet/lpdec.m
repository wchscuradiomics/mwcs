%  LPDEC   Laplacian Pyramid Decomposition
% 
% 	[c, d] = lpdec(x, h, g)
% 
%  Input:
%    x:      input image
%    h, g:   two lowpass filters for the Laplacian pyramid
% 
%  Output:
%    c:      coarse image at half size
%    d:      detail image at full size
% 
%  See also:	LPREC, PDFBDEC
%