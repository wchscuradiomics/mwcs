%  COMPUTESCALE   Comupute display scale for PDFB coefficients
% 
%        computescale(cellDFB, [dRatio, nStart, nEnd, coefMode])
% 
%  Input:
% 	cellDFB:	a cell vector, one for each layer of 
% 		subband images from DFB.
%    dRatio:
%        display ratio. It ranges from 1.2 to 10.
% 
%    nStart:
%        starting index of the cell vector cellDFB for the computation. 
%        Its default value is 1.
%    nEnd:
%        ending index of the cell vector cellDFB for the computation. 
%        Its default value is the length of cellDFB.
%    coefMode: 
%        coefficients mode (a string): 
%            'real' ----  Highpass filters use the real coefficients. 
%            'abs' ------ Highpass filters use the absolute coefficients. 
%                         It's the default value
%  Output:
% 	vScales ---- 1 X 2 vectors for two scales.
% 
%  History: 
%    10/03/2003  Creation.
%    04/01/2004  Limit the display scale into the range of 
%                [min(celldfb), max(celldfb)] or [min(abs(celldfb)), max(abs(celldfb))]
% 
%  See also:     SHOWPDFB
%