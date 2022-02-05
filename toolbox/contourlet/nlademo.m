%  NLADEMO   Demo for contourlet nonlinear approximation. 
%    NLADEMO shows how to use the contourlet toolbox to do nonlinear 
%    approximation. It provides a sample script that uses basic functions 
%    such as pdfbdec, pdfbrec, showpdfb, pdfb_tr, pdfb2vec and vec2pdfb.
% 
%    It can be modified for applications such as denoising, compression, 
%    and computer vision.
% 
%    While displaying images, the program will pause and wait for your response.
%    When you are ready, you can just press Enter key to continue.
% 
%        nlademo( [im, option] )
% 
%  Input:
% 	im:     a double or integer matrix for the input image.
%            The default input is the 'peppers' image.  
%    option: option for the demos. The default value is 'auto'
%        'auto' ------  automtatical demo, no input
%        'user' ------  semi-automatic demo, simple interactive inputs
%        'expert' ----  mannual, complete interactive inputs. 
%                       (It is same as 'user' in this version)
%    
%  See also:     PDFBDEC, PDFBREC, SHOWPDFB, PDFB2VEC, VEC2PDFB
%