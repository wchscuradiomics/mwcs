%  PDFB_TR   Retain the most significant coefficients at certain subbands
% 
% 	ytr = pdfb_tr(y, s, d, [ncoef])
% 
%  Input:
%    y:      output from PDFB
%    s:      scale index (1 is the finest); 0 for ALL scales
%    d:      direction index; 0 for ALL directions
%    ncoef:  [optional] number of most significant coefficients from the
%            specified subbands; default is ALL coefficients.
% 
%  Output
%    ytr:    truncated PDFB output
%