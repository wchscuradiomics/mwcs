%  SHOWPDFB   Show PDFB coefficients. 
% 
%        showpdfb(y, [scaleMode, displayMode, ...
%                     lowratio, highratio, coefMode, subbandgap])
% 
%  Input:
% 	y:	    a cell vector of length n+1, one for each layer of 
% 		    subband images from DFB, y{1} is the lowpass image
% 
%    scaleMode: 
%        scale mode (a string or number):
%            If it is a number, it denotes the number of most significant 
%            coefficients to be displayed.  Its default value is 'auto2'.
%            'auto1' ---   All the layers use one scale. It reflects the real 
%                          values of the coefficients.
%                          However, the visibility will be very poor.
%            'auto2' ---   Lowpass uses the first scale. All the highpass use 
%                          the second scale.
%            'auto3' ---   Lowpass uses the first scale. 
%                          All the wavelet highpass use the second scale.
%                          All the contourlet highpass use the third scale.
%    displayMode: 
%        display mode (a string): 
%            'vb' -----  display the layers vertically in Matlab environment. 
%                        It uses the background color for the marginal
%                        image.
%            'vw' -----  display the layers vertically for print. 
%                        It uses the white color for the marginal
%                        image.
%            'hb' -----  display the layers horizontally in Matlab environment. 
%                        It uses the background color for the marginal
%                        image.
%            'hw' -----  display the layers horizontally for print. 
%                        It uses the white color for the marginal
%                        image.
%    lowratio:
%            display ratio for the lowpass filter (default value is 2).
%            It ranges from 1.2 to 4.0.
%    highratio:
%            display ratio for the highpass filter (default value is 6).
%            It ranges from 1.5 to 10.
%    coefMode: 
%            coefficients mode (a string): 
%            'real' ----  Highpass filters use the real coefficients. 
%            'abs' ------ Highpass filters use the absolute coefficients. 
%                         It is the default value
%    subbandgap:	
%            gap (in pixels) between subbands. It ranges from 1 to 4.
% 
%  Output:
% 	    displayIm:  matrix for the display image.
%    
%  See also:     PDFBDEC, DFBIMAGE, COMPUTESCALE
%