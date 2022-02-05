function FEATURE = extractTraditionalFeatures(method,ROIS,parameter,COEFFS)

%% check parameters and initilize
if nargin == 3
  COEFFS=[];
end
method = upper(method);
if isempty(ROIS)
  nSamples = size(COEFFS,1);
else
  nSamples = size(ROIS,1);
end
initialized = false;
if (sum(contains(method,'LOG')) > 0 || sum(contains(method,'WAVELET')) > 0 || ...
    sum(contains(method,'CONTOURLET')) > 0 || sum(contains(method,'GABOR')) > 0) &&...
    isempty(COEFFS)
  error('COEFFS can not be empty.');
end

%% perform multi-resolution decomposition
% if sum(contains(method,'log')) > 0
%   COEFFS=[ROIS logCoefficients(ROIS,param.graylimits(2),[5 5],1,...
%     parameter.interpolation,parameter.minEdge,parameter.log.way)];
% end
% if sum(contains(method,'wavelet')) > 0
%   COEFFS = waveletCoefficients(removeNans(ROIS),parameter.waveletName,parameter.waveletLevel,...
%     parameter.interpolation,parameter.minEdge);
% end
% if sum(contains(method,'contourlet')) > 0
%   if length(parameter.contourletLevel) > 2
%     COEFFS = contourletCoefficients(removeNans(ROIS),parameter.contourletLevel,8,parameter.minEdge,...
%       parameter.pfilter,parameter.dfilter,parameter.interpolation);
%   else
%     COEFFS = contourletCoefficients(removeNans(ROIS),parameter.contourletLevel,8,parameter.minEdge,...
%       parameter.pfilter,parameter.dfilter,parameter.interpolation);
%   end
% end

%% extract features
switch method
  case 'RST'
   %% RST
    for i=1:nSamples
      p = extractSubbandRawsFeatures(ROIS{i});
      if ~initialized;   [FEATURE,~,initialized] = initFeatureMatrix(nSamples,1,p); end
      FEATURE(i,:) = p;
    end
  case 'GLH'
    %% GLH
    for i=1:nSamples
        p = extractSubbandHistogramFeatures(ROIS{i},[],[],parameter.glh.numLevels,parameter.grayLimits);
        if ~initialized;   [FEATURE,~,initialized] = initFeatureMatrix(nSamples,1,p); end
        FEATURE(i,:) = p;
    end
  case 'GLCM'
    %% GLCM
    for i=1:nSamples
      p = extractSubbandGlcmFeatures(ROIS{i},[],[],parameter.glcm.numLevels,parameter.grayLimits,...
        parameter.glcm.distance,parameter.glcm.averaged);
      if ~initialized;   [FEATURE,~,initialized] = initFeatureMatrix(nSamples,1,p); end
      FEATURE(i,:) = p;
    end
  case 'GLRLM'
    %% GLRLM
    for i=1:nSamples
      p = extractSubbandGlrlmFeatures(ROIS{i},[],[],parameter.glrlm.numLevels,parameter.grayLimits,...
        parameter.glrlm.averaged);
      if ~initialized;   [FEATURE,~,initialized] = initFeatureMatrix(nSamples,1,p); end
      FEATURE(i,:) = p;
    end
  case 'GLDM'
   %% GLDM
    warning('off');
    for i=1:nSamples
      p = extractSubbandGldmFeatures(ROIS{i},[],[],parameter.gldm.numLevels,parameter.grayLimits,...
        parameter.gldm.distance,parameter.gldm.averaged);
      if ~initialized;   [FEATURE,~,initialized] = initFeatureMatrix(nSamples,1,p); end
      FEATURE(i,:) = p;
    end
  case 'AG'
    %% AG
    for i=1:nSamples
      p = extractSubbandAgFeatures(ROIS{i},[],[]);
      if ~initialized;   [FEATURE,~,initialized] = initFeatureMatrix(nSamples,1,p); end
      FEATURE(i,:) = p;
    end
  case 'AR'
    %% AR
    for i=1:nSamples
      p = extractSubbandArFeatures(ROIS{i},[],[],parameter.ar.numLevels,parameter.grayLimits);
      if ~initialized;   [FEATURE,~,initialized] = initFeatureMatrix(nSamples,1,p); end
      FEATURE(i,:) = p;
    end
  case 'LOG'
    %% LOG
    if parameter.log.way ~= 1 % WCODEMAT way
      FEATURE = extractWcodematFeatures(COEFFS,'HIS',parameter.log.numLevels,[],[],parameter.log.absolution);
    else % MATLAB way, the rang of COEFFS{i,j} is [1 parameter.grayLimits(2)]
      nComponents = size(COEFFS,2);
      initialized = false;
      for i=1:nSamples
        for j=1:nComponents
          p = extractSubbandHistogramFeatures(COEFFS{i,j},[],[],parameter.log.numLevels,[1 parameter.grayLimits(2)]);
          if ~initialized;   [FEATURE,nf,initialized] = initFeatureMatrix(nSamples,nComponents,p); end
          FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
        end
      end
    end
  case 'CMS-WRST'  
    FEATURE = extractWcodematFeatures(COEFFS,'RST',parameter.wrst.numLevels,[],[],parameter.w.absolution);
  case 'CMS-WHIS'
    FEATURE = extractWcodematFeatures(COEFFS,'HIS',parameter.whis.numLevels,[],[],parameter.w.absolution);
  case 'CMS-WCOM'
    FEATURE = extractWcodematFeatures(COEFFS,'COM',parameter.wcom.numLevels,parameter.wcom.distance,...
      parameter.wcom.averaged,parameter.w.absolution);
  case 'CMS-WRLM'
    FEATURE = extractWcodematFeatures(COEFFS,'RLM',parameter.wrlm.numLevels,[],...
      parameter.wrlm.averaged,parameter.w.absolution);
  case 'CMS-CRST'
    FEATURE = extractWcodematFeatures(COEFFS,'RST',parameter.crst.numLevels,[],[],parameter.c.absolution);
  case 'CMS-CHIS'
    FEATURE = extractWcodematFeatures(COEFFS,'HIS',parameter.chis.numLevels,[],[],parameter.c.absolution);
  case 'CMS-CCOM'
    FEATURE = extractWcodematFeatures(COEFFS,'COM',parameter.ccom.numLevels,parameter.ccom.distance,...
      parameter.ccom.averaged,parameter.c.absolution);
  case 'CMS-CRLM'
    FEATURE = extractWcodematFeatures(COEFFS,'RLM',parameter.crlm.numLevels,[],...
      parameter.crlm.averaged,parameter.c.absolution);
  otherwise
    error('Invalid method name.');
end