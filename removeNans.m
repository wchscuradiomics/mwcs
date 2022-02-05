function ROIS = removeNans(ROIS,limits)

for i=1:size(ROIS,1)
  I = ROIS{i};
  I(isnan(I)) = limits(1);
  ROIS{i} = I;
end
