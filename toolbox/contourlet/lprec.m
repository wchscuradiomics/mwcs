%  LPDEC   Laplacian Pyramid Reconstruction
% 
% 	x = lpdec(c, d, h, g)
% 
%  Input:
%    c:      coarse image at half size
%    d:      detail image at full size
%    h, g:   two lowpass filters for the Laplacian pyramid
% 
%  Output:
%    x:      reconstructed image
% 
%  Note:     This uses a new reconstruction method by Do and Vetterli,
%            "Framming pyramids", IEEE Trans. on Sig Proc., Sep. 2003.
% 
%  See also:	LPDEC, PDFBREC
%