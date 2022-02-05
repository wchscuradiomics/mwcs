%% find logistic regression parameters
% best = optimizeLrParameters(TRN,TST,li,distribution,training)
% r =  {distribution,link,modelspec,binomialSize,vauc,tauc}
best = optimizeLrParameters(TRN,TST,li);
parameter.lr.distribution = best{1};
parameter.lr.link = best{2};
parameter.lr.modelspec = best{3};
parameter.lr.binomialSize = best{4};

trainLrClassifier(TRN,li.tralabels,li.cvp,...
  parameter.lr.distribution,parameter.lr.link,parameter.lr.modelspec,parameter.lr.binomialSize,false);
testScores=predict(trainedClassifier.lr,TST); 
testScores = [testScores 1-testScores];
testClasses = thresholdScores(testScores,[1 0],0.5);
% ConfusionMat = confusionchart(convertLabels(li.vallabels,[1 2],[1 0]),testClasses);
testResult.lr = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['LR: averaged validation auc=' num2str(validationResult.lr.auc,'%5.4f') ', dc=' num2str(validationResult.lr.dc,'%5.4f') ...
  '; LR: independent test auc=' num2str(testResult.lr.auc,'%5.4f') ', dc=' num2str(testResult.lr.dc,'%5.4f')]);
clear ans testClasses testScores traks trabc tstks tstbc best standardize order ConfusionMat;

%% find svm-linear parameters
% r =  {kernelFunction,kernelScale,boxConstraint,standardize,polynomialOrder,vauc,tauc}
% best = optimizeSvmParameters(TRN,TST,li,kernelFunction,standardize,polynomialOrder,training)
best = optimizeSvmParameters(TRN,TST,li,'linear'); % standardize: true | false

% auto-optimization
% % [trainedClassifier, validationResult] = autoOptimizeSvmParameters(DS,labels,cvp,kernelFunction,optimizer)
% [mdl, vr] = autoOptimizeSvmParameters(TRN,li.tralabels,li.cvp,'linear');
% [~,tscores]=predict(mdl,TST);
% tclasses = thresholdScores(tscores,[1 0],0.5);
% tr = performance(convertLabels(li.vallabels,[1 2],[1 0]),tclasses,tscores,[1 0]);
% disp(vr);
% disp(tr);
% clear ans mdl vr tclasses tscores tr;

% 训练模型 & 保存参数
parameter.svmlinear.kernelFunction = best{1};
parameter.svmlinear.kernelScale = best{2};
parameter.svmlinear.boxConstraint = best{3};
parameter.svmlinear.standardize = best{4};
parameter.svmlinear.polynomialOrder = best{5};
[trainedClassifier.svmlinear, validationResult.svmlinear] = trainSvmClassifier(TRN,li.tralabels,li.cvp,...
  parameter.svmlinear.kernelFunction,parameter.svmlinear.kernelScale,parameter.svmlinear.boxConstraint,...
  parameter.svmlinear.standardize);
[~,testScores]=predict(trainedClassifier.svmlinear,TST);
testClasses = thresholdScores(testScores,[1 0],0.5);
% ConfusionMat = confusionchart(convertLabels(li.vallabels,[1 2],[1 0]),testClasses);
testResult.svmlinear = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['SVM-linear: averaged validation auc=' num2str(validationResult.svmlinear.auc,'%5.4f') ', dc=' num2str(validationResult.svmlinear.dc,'%5.4f') ...
  '; SVM-linear: independent test: auc=' num2str(testResult.svmlinear.auc,'%5.4f') ', dc=' num2str(testResult.svmlinear.dc,'%5.4f')]);
clear ans testClasses testScores traks trabc tstks tstbc best standardize order ConfusionMat;

%% find svm-rbf parameters
% r =  {kernelFunction,kernelScale,boxConstraint,standardize,polynomialOrder,vauc,tauc}
% best = optimizeSvmParameters(TRN,TST,li,kernelFunction,standardize,polynomialOrder,training)
best = optimizeSvmParameters(TRN,TST,li,'rbf'); % standardize: true | false

% auto-optimization
% % [trainedClassifier, validationResult] = autoOptimizeSvmParameters(DS,labels,cvp,kernelFunction,optimizer)
% [mdl, vr] = autoOptimizeSvmParameters(TRN,li.tralabels,li.cvp,'rbf');
% [~,tscores]=predict(mdl,TST);
% tclasses = thresholdScores(tscores,[1 0],0.5);
% tr = performance(convertLabels(li.vallabels,[1 2],[1 0]),tclasses,tscores,[1 0]);
% disp(vr);
% disp(tr);
% clear ans mdl vr tclasses tscores tr;

% 训练模型 & 保存参数
parameter.svmrbf.kernelFunction = best{1};
parameter.svmrbf.kernelScale = best{2};
parameter.svmrbf.boxConstraint = best{3};
parameter.svmrbf.standardize = best{4};
parameter.svmrbf.polynomialOrder = best{5};
[trainedClassifier.svmrbf, validationResult.svmrbf] = trainSvmClassifier(TRN,li.tralabels,li.cvp,...
  parameter.svmrbf.kernelFunction,parameter.svmrbf.kernelScale,parameter.svmrbf.boxConstraint,...
  parameter.svmrbf.standardize);
[~,testScores]=predict(trainedClassifier.svmrbf,TST);
testClasses = thresholdScores(testScores,[1 0],0.5);
% ConfusionMat = confusionchart(convertLabels(li.vallabels,[1 2],[1 0]),testClasses);
testResult.svmrbf = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['SVM-rbf: averaged validation auc=' num2str(validationResult.svmrbf.auc,'%5.4f') ', dc=' num2str(validationResult.svmrbf.dc,'%5.4f') ...
  '; SVM-rbf: independent test auc=' num2str(testResult.svmrbf.auc,'%5.4f') ', dc=' num2str(testResult.svmrbf.dc,'%5.4f')]);
clear ans testClasses testScores traks trabc tstks tstbc best standardize order ConfusionMat;

%% find svm-poy parameters
% r =  {kernelFunction,kernelScale,boxConstraint,standardize,polynomialOrder,vauc,tauc}
% best = optimizeSvmParameters(TRN,TST,li,kernelFunction,standardize,polynomialOrder,training)
best = optimizeSvmParameters(TRN,TST,li,'polynomial'); % standardize: true | false

% auto-optimization
% % [trainedClassifier, validationResult] = autoOptimizeSvmParameters(DS,labels,cvp,kernelFunction,optimizer)
% [mdl, vr] = autoOptimizeSvmParameters(TRN,li.tralabels,li.cvp,'polynomial');
% [~,tscores]=predict(mdl,TST);
% tclasses = thresholdScores(tscores,[1 0],0.5);
% tr = performance(convertLabels(li.vallabels,[1 2],[1 0]),tclasses,tscores,[1 0]);
% disp(vr);
% disp(tr);
% clear ans mdl vr tclasses tscores tr;

% 训练模型 & 保存参数
parameter.svmpolynomial.kernelFunction = best{1};
parameter.svmpolynomial.kernelScale = best{2};
parameter.svmpolynomial.boxConstraint = best{3};
parameter.svmpolynomial.standardize = best{4};
parameter.svmpolynomial.polynomialOrder = best{5};
[trainedClassifier.svmpolynomial, validationResult.svmpolynomial] = trainSvmClassifier(TRN,li.tralabels,li.cvp,...
  parameter.svmpolynomial.kernelFunction,parameter.svmpolynomial.kernelScale,parameter.svmpolynomial.boxConstraint,...
  parameter.svmpolynomial.standardize);
[~,testScores]=predict(trainedClassifier.svmpolynomial,TST);
testClasses = thresholdScores(testScores,[1 0],0.5);
% ConfusionMat = confusionchart(convertLabels(li.vallabels,[1 2],[1 0]),testClasses);
testResult.svmpolynomial = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['SVM-polynomial: averaged validation auc=' num2str(validationResult.svmpolynomial.auc,'%5.4f') ', dc=' num2str(validationResult.svmpolynomial.dc,'%5.4f') ...
  '; SVM-polynomial: independent test: auc=' num2str(testResult.svmpolynomial.auc,'%5.4f') ', dc=' num2str(testResult.svmpolynomial.dc,'%5.4f')]);
clear ans testClasses testScores traks trabc tstks tstbc best standardize order ConfusionMat;

%% PNN
% r =  {'radbas|pazen',spread|sigma,vauc,tauc};
% best = optimizePnnParameters(TRN,TST,li,training)
best = optimizePnnParameters(TRN,TST,li);
parameter.pnn.kernel = best{1};
parameter.pnn.param = best{2};

if strcmpi(parameter.pnn.kernel,'pazen')
  [trainedClassifier.pnn, validationResult.pnn] = trainPpnnClassifier(TRN,li.tralabels,li.cvp,parameter.pnn.param);
  [~,~,testScores] = parzenPNNclassify(trainedClassifier.pnn,TST',parameter.pnn.param);
else
  [trainedClassifier.pnn, validationResult.pnn] = trainNewpnnClassifier(TRN,li.tralabels,li.cvp,parameter.pnn.param);
  testScores = sim(trainedClassifier.pnn,TST')';
end
testClasses = thresholdScores(testScores,[1 0],0.5);
testResult.pnn = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['PNN: averaged validation auc=' num2str(validationResult.pnn.auc,'%5.4f') ', dc=' num2str(validationResult.pnn.dc,'%5.4f') ...
  '; PNN: independent test: auc=' num2str(testResult.pnn.auc,'%5.4f') ', dc=' num2str(testResult.pnn.dc,'%5.4f')]);
clear ans testClasses testScores traks trabc tstks tstbc best standardize order sigma;

%% Bayes
% best = optimizeBayesParameters(TRN,TST,li,prior,training)
% r =  {distributionNames, width, kernel, prior,vauc,tauc}
best = optimizeBayesParameters(TRN,TST,li);
parameter.bayes.distributionNames = best{1};
parameter.bayes.width = best{2};
parameter.bayes.kernel = best{3};
parameter.bayes.prior = best{4};

% 训练模型 & 保存参数
[trainedClassifier.bayes, validationResult.bayes] = trainBayesClassifier(TRN,li.tralabels,li.cvp,...
  parameter.bayes.distributionNames,parameter.bayes.width,parameter.bayes.kernel,parameter.bayes.prior);
[~,testScores]=predict(trainedClassifier.bayes,TST); testScores=[testScores 1-testScores];
testClasses = thresholdScores(testScores,[1 0],0.5);
testResult.bayes = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['Naive Bayes: average validation auc=' num2str(validationResult.bayes.auc)]);
disp(['Naive Bayes: individual test auc=' num2str(testResult.bayes.auc)]);
clear ans testClasses testScores;

%% decision tree
% best = optimizeDtParameters(TRN,TST,li,prior,training)
best = optimizeDtParameters(TRN,TST,li,'empirical'); % prior: empirical (default) | uniform | numeric vector
% r =  {maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,splitCriterion,predictorSelection,prior,vauc,tauc}
parameter.dt.maxNumSplits = best{1};
parameter.dt.minLeafSize = best{2};
parameter.dt.minParentSize = best{3};
parameter.dt.numVariablesToSample = best{4};
parameter.dt.splitCriterion = best{5};
parameter.dt.predictorSelection = best{6};
parameter.dt.prior = best{7};

[trainedClassifier.dt, validationResult.dt] = trainDtClassifier(TRN,li.tralabels,li.cvp,...
  parameter.dt.maxNumSplits,parameter.dt.minLeafSize,parameter.dt.minParentSize,parameter.dt.numVariablesToSample,...
  parameter.dt.splitCriterion,parameter.dt.predictorSelection,parameter.dt.prior,true);
[~,testScores]=predict(trainedClassifier.dt,TST);
testClasses = thresholdScores(testScores,[1 0],0.5);
testResult.dt = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['Decision tree: average validation auc=' num2str(validationResult.dt.auc)]);
disp(['Decision tree: individual test auc=' num2str(testResult.dt.auc)]);
clear ans testClasses testScores;

%% discriminant analysis
% best = optimizeDaParameters(TRN,TST,li,type,prior,training)
% best = optimizeDaParameters(TRN,TST,li,'quadratic','empirical');
% r =  {discrimType,gamma,delta,prior,vauc,tauc}
best = optimizeDaParameters(TRN,TST,li,'linear','empirical'); % prior: empirical (default) | uniform | numeric vector

parameter.da.discrimType = best{1};
parameter.da.gamma = best{2};
parameter.da.delta = best{3};
parameter.da.prior = best{4};
[trainedClassifier.da, validationResult.da] = trainDaClassifier(TRN,li.tralabels,li.cvp,parameter.da.discrimType,...
  parameter.da.gamma,parameter.da.delta,parameter.da.prior);
[~,testScores]=predict(trainedClassifier.da,TST);
testClasses = thresholdScores(testScores,[1 0],0.5);
testResult.da = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['Discriminant analysis: average validation auc=' num2str(validationResult.da.auc)]);
disp(['Discriminant analysis: individual test auc=' num2str(testResult.da.auc)]);
clear ans testClasses testScores;

%% random forest
% best = optimizeRfParameters(TRN,TST,li,prior,training)
best = optimizeRfParameters(TRN,TST,li,'empirical'); % prior: empirical (default) | uniform | numeric vector
% r =  {maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,...
%   splitCriterion,predictorSelection,numLearningCycles,prior,vauc,tauc}
parameter.rf.maxNumSplits = best{1};
parameter.rf.minLeafSize = best{2};
parameter.rf.minParentSize = best{3}; % default 10
parameter.rf.numVariablesToSample = best{4};
parameter.rf.splitCriterion = best{5};
parameter.rf.predictorSelection = best{6};
parameter.rf.numLearningCycles = best{7};
parameter.rf.prior = best{8};

[trainedClassifier.rf, validationResult.rf] = trainRfClassifier(TRN,li.tralabels,li.cvp,...
  parameter.rf.maxNumSplits,parameter.rf.minLeafSize,parameter.rf.minParentSize,...
  parameter.rf.numVariablesToSample,parameter.rf.splitCriterion,parameter.rf.predictorSelection,...
  parameter.rf.numLearningCycles,parameter.rf.prior);
[~,testScores]=predict(trainedClassifier.rf,TST);
testClasses = thresholdScores(testScores,[1 0],0.5);
testResult.rf = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['Random forest: average validation auc=' num2str(validationResult.rf.auc)]);
disp(['Random forest: individual test auc=' num2str(testResult.rf.auc)]);
clear ans testClasses testScores best;

%% ensemble of discriminant analysis
% r =  {discrimType,gamma,delta,subspaceDimension,numLearningCycles,prior,vauc,tauc}
% best = optimizeEdaParameters(TRN,TST,li,type,prior,training)
best = optimizeEdaParameters(TRN,TST,li,type,prior,training);
parameter.eda.discrimType = best{1};
parameter.eda.gamma = best{2};
parameter.eda.delta = best{3};
parameter.eda.subspaceDimension = best{4};
parameter.eda.numLearningCycles = best{5};
parameter.eda.prior = best{6};
[trainedClassifier.eda, validationResult.eda] = trainEdaClassifier(TRN,li.tralabels,li.cvp,...
  parameter.eda.discrimType,parameter.eda.gamma,parameter.eda.delta,...
  parameter.eda.subspaceDimension,parameter.eda.numLearningCycles,parameter.eda.prior);
[~,testScores]=predict(trainedClassifier.esd,TST);
testClasses = thresholdScores(testScores,[1 0],0.5);
testResult.esd = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['Ensemble of discriminative analysis: average validation auc=' num2str(validationResult.eda.auc)]);
disp(['Ensemble of discriminative analysis: individual test auc=' num2str(testResult.eda.auc)]);
clear ans testClasses testScores best;

%% gradient boosting trees
warning('off');
% r =  {imp,maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,...
%   splitCriterion,predictorSelection,numLearningCycles,learnRate,prior,vauc,tauc};
% best = optimizeGbParameters(TRN,TST,li,imp,prior,training)
best = optimizeGbParameters(TRN,TST,li,'GentleBoost'); % AdaBoostM1, GentleBoost, or LogitBoost

parameter.gb.maxNumSplits = best{2};
parameter.gb.minLeafSize = best{3};
parameter.gb.minParentSize = best{4};
parameter.gb.numVariablesToSample = best{5};
parameter.gb.splitCriterion = best{6};
parameter.gb.predictorSelection = best{7};
parameter.gb.numLearningCycles = best{8};
parameter.gb.learnRate = best{9};
parameter.gb.prior = best{10};
[trainedClassifier.gb, validationResult.gb] = trainGbClassifier(TRN,li.tralabels,li.cvp,'GentleBoost',...
	parameter.gb.maxNumSplits,parameter.gb.minLeafSize,parameter.gb.minParentSize,...
	parameter.gb.numVariablesToSample,parameter.gb.splitCriterion,parameter.gb.predictorSelection,...
  parameter.gb.numLearningCycles,parameter.gb.learnRate,parameter.gb.prior);
[~,testScores]=predict(trainedClassifier.gb,TST);
testClasses = thresholdScores(testScores,[1 0],0.5);
testResult.gb = performance(convertLabels(li.vallabels,[1 2],[1 0]),testClasses,testScores,[1 0]);
disp(['Gentle boost tree: average validation auc=' num2str(validationResult.gb.auc)]);
disp(['Gentle boost tree: individual test auc=' num2str(testResult.gb.auc)]);
clear ans testClasses testScores best;

%%
save ROIALONG-TD-GLDM.mat;