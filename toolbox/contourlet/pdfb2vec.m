%  PDFB2VEC   Convert the output of the PDFB into a vector form
% 
%        [c, s] = pdfb2vec(y)
% 
%  Input:
%    y:  an output of the PDFB
% 
%  Output:
%    c:  1-D vector that contains all PDFB coefficients
%    s:  structure of PDFB output, which is a four-column matrix.  Each row
%        of s corresponds to one subband y{l}{d} from y, in which the first two
%        entries are layer index l and direction index d and the last two
%        entries record the size of y{l}{d}.
% 
%  See also:	PDFBDEC, VEC2PDFB
%