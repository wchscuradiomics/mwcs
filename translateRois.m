function ROIS = translateRois(MS,nLevels,wc,ww,way)

if nargin == 4
  way = 'translation';
end

ROIS = cell(size(MS,1),1);

if strcmpi(way,'hu2gray')
  
  for i=1:size(MS,1)
    ROIS{i} = hu2gray(MS{i},nLevels,wc,ww) + 1;
  end
  
else
  
  for i=1:size(MS,1)
    I = MS{i};
    I = I - wc + 1;
    I(I<1) = 1;
    I(I>nLevels) = nLevels;
    ROIS{i} = I;
  end
end