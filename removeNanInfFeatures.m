function [F,invalidFeatureIndices] = removeNanInfFeatures(F)

[~,nanindices]=find(isnan(F));
[~,infindices]=find(isinf(F));
[~,complexindices]=find(iscomplex(F));
invalidFeatureIndices = unique([nanindices;infindices;complexindices])';

% get indices of uniqueNonNanInf columns: validFeatureIndices
if ~isempty(invalidFeatureIndices)  
  F(:,invalidFeatureIndices)=[];
end