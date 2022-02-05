function FEATURE = extractWcodematFeatures(COEFFS,method,numLevels,distance,averaged,absolution)

[nSamples,nComponents] = size(COEFFS);
initialized = false;
method = upper(method);

switch method
  case 'RST'
    for i=1:nSamples
      for j=1:nComponents
        C= COEFFS{i,j};
        if absolution;   C= abs(COEFFS{i,j});  end
        C = cwcodemat(C,numLevels,absolution,'mat'); % discretization
        p = extractSubbandRawsFeatures(C);
        if ~initialized; [FEATURE,nf,initialized] = initFeatureMatrix(nSamples,nComponents,p); end
        FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
      end
    end
  case 'HIS'
    for i=1:nSamples
      for j=1:nComponents
        C = cwcodemat(COEFFS{i,j},numLevels,absolution,'mat');
        p = extractSubbandHistogramFeatures(C,...
          [],[],numLevels,[1 numLevels]);
        if ~initialized;   [FEATURE,nf,initialized] = initFeatureMatrix(nSamples,nComponents,p); end
        FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
      end
    end
  case 'COM'
    for i=1:nSamples
      for j=1:nComponents        
        C = cwcodemat(COEFFS{i,j},numLevels,absolution,'mat'); % RemoveCorners mat
        p = extractSubbandGlcmFeatures(C,...
          [],[],numLevels,[1 numLevels],distance,averaged,'all');
        if ~initialized;   [FEATURE,nf,initialized] = initFeatureMatrix(nSamples,nComponents,p); end
        FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
      end
    end
  case 'RLM'
    for i=1:nSamples
      for j=1:nComponents
        C = cwcodemat(COEFFS{i,j},numLevels,absolution,'mat');
        p = extractSubbandGlrlmFeatures(C,...
          [],[],numLevels,[1 numLevels],averaged);
        if ~initialized;   [FEATURE,nf,initialized] = initFeatureMatrix(nSamples,nComponents,p); end
        FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
      end
    end
  otherwise
    error('Invalid method name.');
end
end