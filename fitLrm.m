warning('off');
% [FEATURE,parameter.invalidFeatureIndices] = removeNanInfFeatures(FEATURE);
% FEATURE = [FEATURE cell2mat(kv) cell2mat(tc)]; % kv/kc are added in the training
% [TRN, TST] = normalizeAllFeatures(FEATURE,li,true);
% subset = selectByLasso(TRN,li.tralabels,li.cvp,parameter.nLimitFeatures,'MSE',1,true);
% % [TRN,TST,indices] = selectByIlfs(ds(:,1),kv,li.traindices,li.valindices,li.tralabels,3,23);
% % [TRN,TST,indices] = selectByMrmr(ds(:,1),kv,li.tralabels,li.valindices,li.tralabels,23);
% TRN = TRN(:,subset); 
% TST = TST(:,subset); 
[trainedClassifier.lr, validationResult.lr] =  trainLrClassifier(TRN,li.tralabels,li.cvp,...
  'binomial','logit','linear',1,true);
% [trainedClassifier.lr, validationResult.lr] = trainLrClassifier(TRN,li.tralabels,li.cvp);
testScores=predict(trainedClassifier.lr,TST); 
testScores = [testScores 1-testScores];
testClasses = double(testScores(:,1)>=0.5);
testResult.lr = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['Logistic Regression: average validation auc=' num2str(validationResult.lr.auc)]);
disp(['Logistic Regression: individual test auc=' num2str(testResult.lr.auc)]);
clear testClasses testScores ans kv1 kv2 ds;