function extractRankedCoefficientFeatures(COEFFS,absolution)

nGroups = size(COEFFS,2);
nSamples = size(COEFFS{1,1},1);

RANKCOEFFS = cell(nSamples, nGroups);

for i=1:nSamples
  for j=1:nGroups
    RANKCOEFFS{i,j}= mergeCoefficientMatrices(COEFFS{j}(i,:));
  end
end

if absolution
  nf = 9;
else
  nf = 18;
end

FEATURE = zeros(nSamples,nf*nGroups);
for i=1:nSamples
  for j=1:nGroups
    C = RANKCOEFFS{i,j};
    C(abs(C)<1e-4)=[]; % remove zeros
    C(isnan(C))=[]; % remove nans
    
    if absolution
      p = extractProperties(abs(C));
    end
  end
end

end

function C = mergeCoefficientMatrices(MATRICES)
  if size(MATRICES,1) ~= 1
    error('MATRICES must be an 1*nComponents cell.');
  end
  nComponents = size(MATRICES,2);
  C = zeros(10000,1);
  k=1;
  for j=1:nComponents
    M = MATRICES{j}(:);
    C(k:k+length(M)-1) = M;
    k = k + length(M);
  end
  C = C(1:k-1);
end

function f = extractProperties(C)
n = length(C);
% features of moments
f1 = sum(C)/n; % the first-order original moment, i.e. mean
f2 = sum(C.^2)/n; % the second-order original moment, i.e. energy or uniformaity
% f3 = sum(C.^3)/n; % the third-order original moment, it's similar to f2. f4 = sum(C.^4)/n; % the
% fourth-order original moment, it's similar to f2. the first-order center moment is 0
m2 = sum((C-f1).^2)/n; % the second-order center moment, i.e. variance
f5 = sqrt(m2); % standard deviation
m3 = sum((C-f1).^3)/n; % the third-order center moment, it means more in histogram.
m4 = sum((C-f1).^4)/n; % the fourth-order center moment, it means more in histogram.
f6 = m3/(m2^1.5); % skewness
f7 = m4/(m2^2)-3; % kurtosis. "Minus 3" is to make the kurtosis of the normal distribution 0
f8 = 1 - 1/(1+m2); % smooth

f9 = -sum(C.*log2(C))/n;
f10 = max(C);
f11 = min(C);

% widely used statistics f8 = 1-1/(1+m2/(gl(2)-gl(1))^2); % smooth, it means more in histogram.
% contrast, homogeneity, etc. are not meaning here due to i and j are not gray-level, they are
% positions. indices = find(C>0); nIndices = length(indices); f9 =
% -sum(C(indices).*log2(C(indices)))/length(indices);  % entropy, it means more in histogram.

f=[f1 f2 f5 f6 f7 f8 f9 f10 f11];
end


