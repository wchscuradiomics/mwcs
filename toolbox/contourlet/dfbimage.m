%  DFBIMAGE    Produce an image from the result subbands of DFB
% 
% 	im = dfbimage(y, [gap, gridI])
% 
%  Input:
% 	y:	output from DFBDEC
% 	gap:	gap (in pixels) between subbands
% 	gridI:	intensity of the grid that fills in the gap
% 
%  Output:
% 	im:	an image with all DFB subbands
% 
%  The subband images are positioned as follows 
%  (for the cases of 4 and 8 subbands):
% 
%      0   1              0   2
%               and       1   3
%      2   3            4 5 6 7
%