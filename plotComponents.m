% clear;clc; 
% load('ROIALONG-MSTA-RBIO31-SORTABS.mat');
idx = 69;
ROI = ROIS{idx};
CS = COEFFS(idx,:);
CS([1 5 9]) = [];
MCS = MAXS(idx,:);
imshow(ROI,[1 128]);

parameter.nLevels = round(parameter.mm(2,:) - parameter.mm(1,:))+1;
sequence = 1:parameter.nLevels;
edges = cell(1,size(MCS,2));
du = ones(1,size(MCS,2)); 
for j=1:size(MCS,2)
  MCS{j} = abs(MCS{j});
  CS{j} = abs(CS{j});
  edges{j} = [parameter.mm(1,j):du(j):((parameter.nLevels-1)*du(j)+parameter.mm(1,j)) Inf];
  % sequence = 1:parameter.nLevels;
end

DMCS = cell(size(MCS));
for j=1:length(MCS)
  DMCS{j} = discretize(MCS{j},edges{j},sequence);
end

for i=1:9
  subplot(3,3,i),imshow();
end
