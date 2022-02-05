%  REBACKSAMP   Re-backsampling the subband images of the DFB
% 
% 	y = rebacksamp(y)
% 
%  Input and output are cell vector of dyadic length
% 
%  This function is call at the begin of the DFBREC to undo the operation
%  of BACKSAMP before process filter bank reconstruction.  In otherword,
%  it is inverse operation of BACKSAMP
% 
%  See also:	BACKSAMP, DFBREC
%