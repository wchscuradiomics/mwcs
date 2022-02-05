% Convert a dicom to a grayscale image with [0 nLevels-1].
% 
%  fileName: a char vector specifying the full path of a dicom file, or a structure containing meta
%  data.
% 
%  nLevels: an integer specifying the grayscale ([0 nLevels-1]) of the converted grayscale image. If
%  nLevels is 256, then I is uint8 ([0 255]); if nLevels is 65536, then I is uint16 ([0 65535]); else
%  I is double. If nargin == 1, then set nLevels = 256 and use default windowCenter and windowWidth.
%  If nLevels is [], then set nLevels = windowWidth.
% 
%  windowCenter: an integer specifying the window center used for converting.
% 
%  windowWidth: an integer specifying the window width used for converting.
% 
%  I: a grayscale image with grayscale [0 nLevels-1].
% 
%  info: a structure of meta data representing the dicom file.
%