function rois = reconstructRectangles(rois)

rois = [rois repmat({''},size(rois,1),1)];

for i = 1:length(rois)
  [~, ~, ~, M] = findLargestRectangle(rois{i,2}, [1 1 0], [12 12]);
  [rs,re,cs,ce] = trimBinaryImage(M);
  % D = rois{i,5};
  rois{i,end} = rois{i,5}(rs:re,cs:ce);
end