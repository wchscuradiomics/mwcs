function F  = extractMaxicofFeatures(MAXS)

nComponents = size(MAXS,2);
nf = 14;
F = zeros(size(MAXS,1),nf*nComponents);
for i=1:size(MAXS,1)
  for j=1:size(MAXS,2)
    F(i,(j*nf-nf+1):(j*nf))= extractSubbandMaxicofFeatures(MAXS{i,j});
  end
end