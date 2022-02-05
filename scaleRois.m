function ROIS = scaleRois(MS,gl,nLevels)

ROIS = cell(size(MS,1),1);
for i=1:size(MS,1)
  ROIS{i} = convertGrayscale(MS{i},gl,nLevels);
end

