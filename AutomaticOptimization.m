%% SVM linear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[classifier, valresult] = autoOptimizeSvmParameters(TRN,li.tralabels,li.cvp,'linear','gridsearch',true);
[~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);


%% LDA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[classifier, valresult] = autoOptimizeDaParameters(TRN,li.tralabels,li.cvp,'gridsearch');
[~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);


%% ELDA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[classifier, valresult] = autoOptimizeEdaParameters(TRN,li.tralabels,li.cvp,'gridsearch',true);  
[~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);


%% SVM-RBF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[classifier, valresult] = autoOptimizeSvmParameters(TRN,li.tralabels,li.cvp,'rbf','gridsearch',true);
[~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);


%% Bayes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[classifier, valresult] = autoOptimizeBayesParameters(TRN,li.tralabels,li.cvp,'gridsearch');
[~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);


%% DT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[classifier, valresult] = autoOptimizeDtParameters(TRN,li.tralabels,li.cvp,'gridsearch');
[~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);


%% AdaBoostM1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[classifier, valresult] = autoOptimizeGbParameters(TRN,li.tralabels,li.cvp,'AdaBoostM1','gridsearch');
[~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);


%% GentleBoost
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[classifier, valresult] = autoOptimizeGbParameters(TRN,li.tralabels,li.cvp,'GentleBoost','gridsearch');
[~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);


%% LogitBoost
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[classifier, valresult] = autoOptimizeGbParameters(TRN,li.tralabels,li.cvp,'LogitBoost','gridsearch');
[~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);


%% RF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[classifier, valresult] = autoOptimizeRfParameters(TRN,li.tralabels,li.cvp,'gridsearch');
[~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);
