function RROIS = reconstructRois(ROIS,pss,ps,method,limits)

if nargin == 2
  ps = [0.625 0.625];
  method = 'linear';
  limits = [1 256];
end

RROIS = cell(length(ROIS),1);
for i = 1:length(ROIS)
  RROIS{i} = dicomReconstruct(ROIS{i},pss{i},ps,limits,1,method);
end