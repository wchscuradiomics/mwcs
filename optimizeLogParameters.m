function [best1,best2] = optimizeLogParameters(ROIS,kv,li,minNumLevels,maxNumLevels,original)

if nargin == 5
  original = false;
end

nf = 12;

%% MATLAB WAY
COEFFS=logCoefficients(ROIS,maxNumLevels,[5 5],1,'bilinear',16,1);
if original
  COEFFS = [ROIS COEFFS];
end
nSamples = size(COEFFS,1);
levels = minNumLevels:8:maxNumLevels;
RESULT1S = cell(length(levels),4);

disp('Now MATLAB WAY...');
parfor ipar = 1:length(levels)
  FEATURE = zeros(nSamples,nf*size(COEFFS,2));
  
  for i=1:nSamples
    for j=1:size(COEFFS,2)
      p = extractSubbandHistogramFeatures(COEFFS{i,j},[],[],levels(ipar),[1 maxNumLevels]);      
      FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
    end
  end
  
  [FEATURE,~] = removeNanInfFeatures(FEATURE);
  ds = normalizeAllFeatures(FEATURE,li,true);
  [TRN,TST,subset] = selectByLasso(ds(:,1),kv,li.traindices,li.valindices,li.tralabels,'MSE',li.cvp,1,23,true);
  msg = ['************************** MATLAB WAY numLevel=' num2str(levels(ipar))  ' **************************' 13 ...
    'Length of subset = ' num2str(length(subset))];
  RESULT1S(ipar,:) = dispLrResult(TRN,TST,li,levels(ipar),'MATLAB',msg);
end

disp('Now WCODEMAT WAY...');

%% WCODEMAT
COEFFS=logCoefficients(ROIS,maxNumLevels,[5 5],1,'bilinear',16,2);
if original
  COEFFS = [ROIS COEFFS];
end
nSamples = size(COEFFS,1);
levels = minNumLevels:8:maxNumLevels;
RESULT2S = cell(2,1);
for absolution=0:1  
  RESULTS = cell(length(levels),4);
  parfor ipar = 1:length(levels)
    FEATURE = zeros(nSamples,nf*size(COEFFS,2));
    
    for i=1:nSamples
      for j=1:size(COEFFS,2)
        p = extractSubbandHistogramFeatures(wcodemat(COEFFS{i,j},levels(ipar),'mat',absolution),...
          [],[],levels(ipar),[1 levels(ipar)]);        
        FEATURE(i,(j*nf-nf+1):(j*nf)) = p;
      end
    end
    
    [FEATURE,~] = removeNanInfFeatures(FEATURE);
    ds = normalizeAllFeatures(FEATURE,li,true);
    [TRN,TST,subset] = selectByLasso(ds(:,1),kv,li.traindices,li.valindices,li.tralabels,'MSE',li.cvp,1,23,true);
    msg = ['************************** WCODEMAT ' num2str(absolution) ' numLevel=' num2str(levels(ipar))  ' **************************' 13 ...
      'Length of subset = ' num2str(length(subset))];
    RESULTS(ipar,:) = dispLrResult(TRN,TST,li,levels(ipar), ['WCODEMAT ' num2str(absolution)] ,msg);   
  end
  RESULT2S{absolution+1} = RESULTS;
end

RESULT2S= [RESULT2S{1};RESULT2S{2}];

R = [RESULT1S;RESULT2S;];
indice1s = printBestPerformance(R,3,-5);
indice2s = printBestPerformance(R,4,-5);
best1 = R(indice1s(1),:);
best2 = R(indice2s(1),:);
end

function r = dispLrResult(TRN,TST,li, numLevels, way, msg)
[trainedClassifier.lr, validationResult.lr] = trainLrClassifier(TRN,li.tralabels,li.cvp);
testScores=predict(trainedClassifier.lr,TST);
testScores = [testScores 1-testScores];
testClasses = double(testScores(:,1)>=0.5);
testResult.lr = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);

disp([msg 13 'Logistic Regression: average validation auc=' num2str(validationResult.lr.auc)  13 ...
  'Logistic Regression: individual test auc=' num2str(testResult.lr.auc) 13]);

r = {way,numLevels,validationResult.lr.auc,testResult.lr.auc};
end