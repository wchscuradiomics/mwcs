function masks = modify(masks)

if size(masks,2) ~= 2
  error('masks must contain path information.');
end

masks = [masks repmat({''},size(masks,1),5)];

for i=1:length(masks)
  info = dicominfo(masks{i,1});
  masks{i,3} = info.PixelSpacing;
  masks{i,4} = info.KVP;
  SV = double(dicomread(masks{i,1}));
  MODALITY = info.RescaleSlope * SV + info.RescaleIntercept;
  masks{i,5} = MODALITY;
  [rs,re,cs,ce] = boundBox(masks{i,2});
  masks{i,6} = MODALITY(rs:re,cs:ce);
  MODALITY(~masks{i,2}) = nan;
  masks{i,7} = MODALITY(rs:re,cs:ce);
  % disp([num2str(info.PixelSpacing(1)) ',' num2str(info.PixelSpacing(2)) ': ' num2str(info.KVP)]);
end