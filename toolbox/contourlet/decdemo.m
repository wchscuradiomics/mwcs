%  DECDEMO   Demonstrates contourlet decomposition and reconstruction. 
% 
%    DECDEMO shows how to use the contourlet toolbox to decompose
%    and reconstruct an image.  It provides a sample script that uses 
%    basic functions such as pdfbdec, pdfbrec, showpdfb.
% 
%    It can be modified for applications such as image analysis, 
%    image retrieval and image processing.
% 
%    While displaying images, the program will pause and wait for your response.
%    When you are ready, you can just press Enter key to continue.
% 
%        decdemo( [im, option] )
% 
%  Input:
% 	image:  a double or integer matrix for the input image.
%            The default is the zoneplate image.
%    option: option for the demos. The default value is 'auto'
%        'auto' ------  automtatical demo, no input
%        'user' ------  semi-automatic demo, simple interactive inputs
%        'expert' ----  mannual, complete interactive inputs. 
%                       (Not implmented in this version)
% 
%  Output:
% 	coeffs: a cell vector for the contourlet decomposition coefficients.
%    
%  See also:     PDFBDEC, PDFBREC, SHOWPDFB
%