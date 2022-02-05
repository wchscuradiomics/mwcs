function MASK = segroi(fileName)
%Segment an ROI from a delineated image I.
%
% fileName: a character vector specifying the file name of I.
%
% MASK: a logical matrix, where values 1 specifying the ROI.

if nargin == 1 && strcmpi(fileName((end-3):end),'.bmp')
  fileName = replace(lower(fileName),'.bmp','');
  fileName = replace(lower(fileName),'.dcm','');
  I = imread([fileName '.bmp']);
  
  RedChannel = I(:, :, 1);
  GreenChannel = I(:, :, 2);
  BlueChannel = I(:, :, 3);
  Line = RedChannel == 255 & GreenChannel  == 0 & BlueChannel == 0;
  if  sum(Line,'all') < 4
    error('no label');
  end
  MASK = imfill(Line, 'holes');
  MASK(Line) = 0;
else
  error('该函数目前只支持对BMP勾画的分割，待扩展！');
end