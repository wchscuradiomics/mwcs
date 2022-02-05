function FEATURE = extractMstaFeatures(COEFFS,mm,method,numLevels,distance,averaged,absolution)

%% check absolution && initialize
[nSamples, nComponents] = size(COEFFS);
if nComponents ~= size(mm,2); error('The number of components must be equal to the number of columns in mm.'); end
if absolution
  for i=1:nSamples
    for j=1:nComponents
      COEFFS{i,j} = abs(COEFFS{i,j});
    end
  end
end
method = upper(method);
initialized = false;

%% various method
switch method
  case 'RST'
    for i=1:nSamples
      for j=1:nComponents
        C = convertGrayscale(COEFFS{i,j},mm(:,j)',numLevels);
        p = extractSubbandRawsFeatures(C);
        if ~initialized; [FEATURE,nf,initialized] = initFeatureMatrix(nSamples,nComponents,p); end
        FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
      end
    end
  case 'HIS'
    for i=1:nSamples
      for j=1:nComponents
        p = extractSubbandHistogramFeatures(COEFFS{i,j},[],[],numLevels,mm(:,j)');
        if ~initialized; [FEATURE,nf,initialized] = initFeatureMatrix(nSamples,nComponents,p); end
        FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
      end      
    end
  case 'COM'
    for i=1:nSamples
      for j=1:nComponents
        C = COEFFS{i,j};
        % indices = zeroCorners(C);
        % C(indices)= nan;
        limits = mm(:,j)';        
        % C= round(C); % 
        p = extractSubbandGlcmFeatures(C,[],[],numLevels,limits,distance,averaged,'all');
        if ~initialized; [FEATURE,nf,initialized] = initFeatureMatrix(nSamples,nComponents,p); end
        FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
      end      
    end
  case 'RLM'
    for i=1:nSamples
      for j=1:nComponents
        p = extractSubbandGlrlmFeatures(COEFFS{i,j},[],[],numLevels,mm(:,j)',averaged);
        if ~initialized; [FEATURE,nf,initialized] = initFeatureMatrix(nSamples,nComponents,p); end
        FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
      end      
    end
  otherwise
    error('Invalid method name.');
end


