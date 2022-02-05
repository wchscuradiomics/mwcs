function FEATURE = extractMmTextureFeatures(method,parameter,COEFFS)
%Extract features using mean minimums and mean maximums.
%FEATURE = extractMmTextureFeatures(method,parameter,COEFFS)
%
% As for methods based on wavelet transform and contourlet transform, the parameter absolution is
% appliable for all sub-methods. That are, parameter.mstaw.absolution and parameter.mstac.absolution.

%% check parameters and initilize
method = upper(method);
nSamples = size(COEFFS,1);

%% extract features
switch method
  case 'MSTA-WRST'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmw,'RST',parameter.mstawrst.numLevels,[],[],parameter.mstaw.absolution);
  case 'MSTA-WHIS'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmw,'HIS',parameter.mstawhis.numLevels,[],[],parameter.mstaw.absolution);
  case 'MSTA-WCOM'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmw,'COM',parameter.mstawcom.numLevels,...
      parameter.mstawcom.distance,parameter.mstawcom.averaged,parameter.mstaw.absolution);
  case 'MSTA-WRLM'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmw,'RLM',parameter.mstawrlm.numLevels,...
      [],parameter.mstawrlm.averaged,parameter.mstaw.absolution);
  case 'MSTA-CRST'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmc,'RST',parameter.mstacrst.numLevels,[],[],parameter.mstac.absolution);
  case 'MSTA-CHIS'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmc,'HIS',parameter.mstachis.numLevels,[],[],parameter.mstac.absolution);
  case 'MSTA-CCOM'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmc,'COM',parameter.mstaccom.numLevels,...
      parameter.mstaccom.distance,parameter.mstaccom.averaged,parameter.mstac.absolution);
  case 'MSTA-CRLM'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmc,'RLM',parameter.mstacrlm.numLevels,...
      [],parameter.mstacrlm.averaged,parameter.mstac.absolution);
  case 'MWCS-RST'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmw,'RST',parameter.mwcsrst.numLevels,[],[],parameter.mwcs.absolution);
  case 'MWCS-HIS'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmw,'HIS',parameter.mwcshis.numLevels,[],[],parameter.mwcs.absolution);
  case 'MWCS-COM'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmw,'COM',parameter.mwcscom.numLevels,...
      parameter.mwcscom.distance,parameter.mwcscom.averaged,parameter.mwcs.absolution);
  case 'MWCS-RLM'
    FEATURE = extractMstaFeatures(COEFFS,parameter.mmw,'RLM',parameter.mwcsrlm.numLevels,...
      [],parameter.mwcsrlm.averaged,parameter.mwcs.absolution);
  otherwise
    error('Invalid method name.');
end