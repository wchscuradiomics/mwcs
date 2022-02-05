clc;
warning('off');
for w=45:45
  COEFFS = waveletCoefficients(removeNans(ROIS),wavenames{w},parameter.waveletLevel,...
    parameter.interpolation,parameter.minEdge);
  checkNanCoefficients(COEFFS,parameter.waveletName);
  
  MAXS = maxabs2({COEFFS(:,2:4) COEFFS(:,6:8) COEFFS(:,10:12)});
  TRAMAXS = MAXS(li.traindices,:);
  TSTMAXS = MAXS(li.valindices,:);
  [parameter.mm,parameter.mm1,parameter.mm2] = mmCoefficients(TRAMAXS(li.tralabels == 1,:),TRAMAXS(li.tralabels == 2,:),true,true);
  FEATURE = extractMmTextureFeatures(MAXS,4,parameter);
  % FEATURE = extractMaxicofFeatures(MAXS);
  [FEATURE,parameter.invalidFeatureIndices] = removeNanInfFeatures(FEATURE);
  ds = normalizeAllFeatures(FEATURE,li,true);  
  [TRN,TST,subset] = selectByLasso(ds(:,1),kv,li.traindices,li.valindices,li.tralabels,'MSE',li.cvp,1);
  % [TRN,TST,indices] = selectByIlfs(ds2(:,1),kv,li.traindices,li.valindices,li.tralabels,3,13);
  % [TRN,TST,indices] = selectByMrmr(ds2(:,1),li.tralabels,23);  
  [trainedClassifier.lr, validationResult.lr] = trainLrClassifier(TRN,li.tralabels,li.cvp);
  testScores=predict(trainedClassifier.lr,TST); testClasses = double(testScores>=0.5);
  testResult.lr = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
  disp(['wave=' wavenames{w}]) ;
  disp(['Logistic Regression: average validation auc=' num2str(validationResult.lr.auc)]);
  disp(['Logistic Regression: individual test auc=' num2str(testResult.lr.auc)]);
  disp('*****************************************************************************'); 
end

