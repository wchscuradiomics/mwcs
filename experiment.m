%% Load dataset
clear;clc;
load dataset;

% rois{336,8},336 samples
% 2-th column: mask (ROI region); 3-th column: pixel spacing; 
% 4-th column: peak kilo voltage; 5-th column: x-ray tube current;
% 6-th column: CT (HU); 7-th: trimmed rectangular ROIs; 8-th column: trimmed rectangular ROIs (fill cornors with NaNs)

% li.
% labels: class 1 -> HCC; class 0 -> HEM
% traindices: indices of training samples (be partitioned into 10 folds, used for 10-fold cross-validation)
% valindices: indices of independent test samples
% cvp: partitions of 10-folds 
% tralabels: labels of training samples
% vallabels: labels of test samples

%% Reconstruct 2D DICOMs
% Trim an ROI from its MASK, reconstruct an ROI based on 'PixelSpacing', translate and linearly scale an ROI 

parameter.pixelSpacing = [.625,.625];
parameter.reconstructMethod = 'linear';
ROIS = reconstructRois(rois(:,8), rois(:,3),parameter.pixelSpacing,parameter.reconstructMethod,[-Inf Inf]); 
ROIS = translateRois(ROIS,128,55,128,'hu2gray'); % the last parameter ishu2gray or translation
ROIS = fitRois(ROIS,128,'FillNaN'); % fill cornors with NaNs

kv = rois(:,4); % peak kilo voltage
tc = rois(:,5); % x-ray tube current;
 
%% Calculate the entropy corresponding to each wavelet
load wavenames; % 52 wavelets
ENTS = zeros(length(wavenames),length(li.tralabels),9);
for k=1:length(wavenames)
  % wavelet transform
  % Zero-padding ('zpd'): This method is used in the version of the DWT given in the previous sections and assumes that the
  % signal is zero outside the original support. Thus, it should fill the cornors with background.
  COEFFS = waveletCoefficients(removeNans(ROIS(li.traindices,:),[1 128]),wavenames{k},3,...
    'linear',16,'integer',[1 128],'zpd');   
  COEFFS(:,[1 5 9]) = []; % remove low-frequency components  
  
  for i=1:size(COEFFS,1) % calculate an entropy value for a component
    for j = 1:size(COEFFS,2)
      ENTS(k,i,j) = centropy(COEFFS{i,j},128,[],1);
    end
  end
end
clear i j k ans COEFFS COEFF3S A w mm m
% [m,i] = max( sum(ENTS,[2,3]) ); % m = 9.8340e+03; i = 45;
% [m,i] = max( avg(ENTS,[2,3]) );

%% Shared parameters
parameter.wc = 55;
parameter.ww = 128;
parameter.grayLimits = [1 128];
parameter.msta.grayLimits = '[mm(1,j) mm(2,j)]';
parameter.waveletName = 'rbio3.1';
parameter.contourletLevel = [2 3];
parameter.waveletLevel = 3;
parameter.minEdge = 16;
parameter.pfilter = '9-7';
parameter.dfilter = 'pkva6';
parameter.interpolation = 'linear';
parameter.nLimitFeatures = 23; 
parameter.glcm.distance = 2;
parameter.wcom.distance = 2; % wcom: wavelet co-occurrence matrix
parameter.ccom.distance = 3; % ccom: contourlet co-occurrence matrix
parameter.glcm.averaged = 1;
parameter.wcom.averaged = 1;
parameter.ccom.averaged = 1;
parameter.glrlm.averaged = 1;
parameter.wrlm.averaged = 1; % wrlm: wavelet run-length matrix
parameter.crlm.averaged = 1; % crlm: contourlet run-length matrix
parameter.w.absolution = 1; % w: wavelet
parameter.c.absolution = 1; % c: countourlet
parameter.mstaw.absolution = 1; % mstaw: MSTA-wavelet
parameter.mstac.absolution = 1; % mstac: MSTA-contourlet
parameter.mwcs.absolution = 1; % MWCS: maxmim wavelet coefficient statistics

%% wavelet transform & contourlet transform & LoG filtering
COEFFWS = waveletCoefficients(ROIS,parameter.waveletName,parameter.waveletLevel,...
	parameter.interpolation,parameter.minEdge,'integer',parameter.grayLimits,'zpd'); % [1 5 9] are approximate components
COEFFCS = contourletCoefficients(ROIS,parameter.contourletLevel,4,parameter.minEdge,...
  parameter.pfilter,parameter.dfilter,parameter.interpolation,'integer',parameter.grayLimits,'zpd');
checkNanCoefficients(COEFFWS,parameter.waveletName);
checkNanCoefficients(COEFFCS,[parameter.pfilter '&' parameter.dfilter]);

%% MSTA
% select high-frequency components
MSTAWCOEFFS = [COEFFWS(:,2:4) COEFFWS(:,6:8) COEFFWS(:,10:12)]; % only use the high-frequency components
% MSTACOEFFS = COEFFWS; % use high-frequency components and low-frequency components

% calculate MM (mean minimums and mean maximums) for each selected component
TRAMSTAWCOEFFS = MSTAWCOEFFS(li.traindices,:);
[parameter.mmw,parameter.mmw1,parameter.mmw2] = mmCoefficients(TRAMSTAWCOEFFS(li.tralabels==1,:),...
  TRAMSTAWCOEFFS(li.tralabels == 0,:),true,true,'');

% find optimized NumLevels based on a scheme of grid search:

% 1) MSTA-WRST
% optimizeNumLevel4Tam('MSTA-WRST',[],kv,tc,li,8,128,parameter,MSTAWCOEFFS,true);

% 2) MSTA-WHIS
% optimizeNumLevel4Tam('MSTA-WHIS',[],kv,tc,li,8,128,parameter,MSTAWCOEFFS);
% parameter.mstawcom.averaged = 1;
% parameter.mstawcom.distance = 3;
% optimizeNumLevel4Tam('MSTA-WCOM',[],kv,tc,li,8,128,parameter,MSTAWCOEFFS,true);

% 3) MSTA-WRLM
% parameter.mstawrlm.averaged = 1;
% [bestrain, bestest] = optimizeNumLevel4Tam('MSTA-WRLM',[],kv,tc,li,8,128,parameter,MSTAWCOEFFS);

%% MWCS
% reorganize components
MWCSCOEFFS = maxabs({COEFFWS(:,2:4) COEFFWS(:,6:8) COEFFWS(:,10:12)});

% After reorganization，cols of 1, 2, and 3 are in the first-level decomposition, cols of 4, 5, and 6
% are in the second-level decomposition, cols of 7, 8, and 9 are in the third-level decomposition.
% Pick out the first matrix in each level:
MWCSCOEFFS = MWCSCOEFFS(:,[1 4 7]); 

% calculate MM (mean minimums and mean maximums)
TRAMWCSCOEFFS = MWCSCOEFFS(li.traindices,:);
[parameter.mmw,parameter.mmw1,parameter.mmw2] = mmCoefficients(TRAMWCSCOEFFS(li.tralabels == 1,:),...
  TRAMWCSCOEFFS(li.tralabels == 0,:),true,true,''); % absolution,mvmv,RemoveCorners

% find optimized NumLevels based on a scheme of grid search:

% 1) MWCS-RST
% optimizeNumLevel4Tam('MWCS-RST',[],kv,tc,li,8,128,parameter,MWCSCOEFFS,true);

% 2) MWCS-HIS
% optimizeNumLevel4Tam('MWCS-HIS',[],kv,tc,li,8,128,parameter,MWCSCOEFFS,true);

% 3) MWCS-COM
parameter.mwcscom.averaged = 1;
parameter.mwcscom.distance = 3; % from 1 to 5
optimizeNumLevel4Tam('MWCS-COM',[],kv,tc,li,8,128,parameter,MWCSCOEFFS,true);

% 4) MWCS-RLM
% parameter.mwcsrlm.averaged = 1;
% optimizeNumLevel4Tam('MWCS-RLM',[],kv,tc,li,8,128,parameter,MWCSCOEFFS,true);

%% RST
% if no discretization, minNumLevels to maxNumLevels set to 1:1, i.e., optimizeNumLevel4Tam('CMS-WRST',[],kv,tc,li,1,1,parameter,CS,true); 
optimizeNumLevel4Tam('RST',ROIS,kv,tc,li,1,1,parameter,[],true); 

%% GLH
optimizeNumLevel4Tam('GLH',ROIS,kv,tc,li,8,128,parameter,[],true);

%% GLCM
parameter.glcm.distance=5; % distance from 1 to 5
optimizeNumLevel4Tam('GLCM',ROIS,kv,tc,li,8,128,parameter,[],true);

%% GLRLM
optimizeNumLevel4Tam('GLRLM',ROIS,kv,tc,li,8,128,parameter,[],true);

%% GLDM
parameter.gldm.averaged = 1;
parameter.gldm.distance = 4; % distance from 1 to 5
optimizeNumLevel4Tam('GLDM',ROIS,kv,tc,li,8,128,parameter,[],true); 

%% AG
optimizeNumLevel4Tam('AG',ROIS,kv,tc,li,1,1,parameter,[],true);

%% AR
optimizeNumLevel4Tam('AR',ROIS,kv,tc,li,8,128,parameter,[],true); 

%% LoG
warning('off');
parameter.log.absolution = 0; 
parameter.log.way=1; % way=1: MATLAB way, keep grayscale rang as [1 128]; way=2: WCODEMAT way (normalize to [0 1])
COEFFLS = [ROIS logCoefficients(ROIS,parameter.grayLimits,[5 5],'integer',...
  parameter.interpolation,parameter.minEdge,parameter.log.way)];
optimizeNumLevel4Tam('LOG',[],kv,tc,li,8,128,parameter,COEFFLS);

%% CMS, i.e., coefficient matrix scaling -> WAVELET+Statistics / WAVELET + wcodemat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WAVELET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CS = COEFFWS;
CS(:,[1 5 9]) = []; % just for the detailed components

% find optimized NumLevels based on a scheme of grid search:

% 1) CMS-WRST
% if no discretization, minNumLevels to maxNumLevels set to 1:1, 
% i.e., optimizeNumLevel4Tam('CMS-WRST',[],kv,tc,li,1,1,parameter,CS,true); 
optimizeNumLevel4Tam('CMS-WRST',[],kv,tc,li,8,128,parameter,CS,true); 

% 2) CMS-WHIS
optimizeNumLevel4Tam('CMS-WHIS',[],kv,tc,li,8,128,parameter,CS,true);

% 3) CMS-WCOM
parameter.wcom.distance=3; % from 1 to 5
optimizeNumLevel4Tam('CMS-WCOM',[],kv,tc,li,8,128,parameter,CS,true);

% 4) CMS-WRLM
optimizeNumLevel4Tam('CMS-WRLM',[],kv,tc,li,8,128,parameter,CS,true);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CONTOURLET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CS = COEFFCS;
CS(:,[1 6]) = []; % just for the detailed components

% find optimized NumLevels based on a scheme of grid search:

% 1) CMS-CRST
% if no discretization, minNumLevels to maxNumLevels set to 1:1, 
% i.e., optimizeNumLevel4Tam('CMS-WRST',[],kv,tc,li,1,1,parameter,CS,true); 
optimizeNumLevel4Tam('CMS-CRST',[],kv,tc,li,1,1,parameter,CS,true); 

% 2) CMS-CHIS
optimizeNumLevel4Tam('CMS-CHIS',[],kv,li,8,128,parameter,CS);

% 3) CMS-CCOM
parameter.ccom.distance = 5; % from 1 to 5
optimizeNumLevel4Tam('CMS-CCOM',[],kv,tc,li,8,128,parameter,CS,true);

% 4) CMS-CRLM
parameter.crlm.averaged = 1;
optimizeNumLevel4Tam('CMS-CRLM',[],kv,tc,li,8,128,parameter,CS,true);

%% extract features: parameters have been optimized by trying optimizeNumLevel4Tam
% just load feature.mat, or: 

%% 1) extrct features using AG AR GLDM LOG RST GLH GLCM GLRLM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% a) using fitted ROIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data preprocess: reconstruc, translate, and fit.
% FIT means that the corners of ROIS have been fitted with grayLimits(1).
AGFEATURE = extractTraditionalFeatures('AG',ROIS,parameter,[]); % AG-FIT. 
parameter.ar.numLevels = 64;
ARFEATURE = extractTraditionalFeatures('AR',ROIS,parameter,[]); % AR-FIT
parameter.glrlm.numLevels = 52;
GLRLMFEATURE = extractTraditionalFeatures('GLRLM',ROIS,parameter,[]); % GLRLM-FIT
parameter.gldm.averaged = 1;
parameter.gldm.numLevels = 16;
parameter.gldm.distance = 5;
GLDMFEATURE = extractTraditionalFeatures('GLDM',ROIS,parameter,[]); % GLDM-D5-FIT
parameter.glcm.averaged = 1;
parameter.glcm.numLevels = 68;
parameter.glcm.distance = 3;
GLCMFEATURE = extractTraditionalFeatures('GLCM',ROIS,parameter,[]); % GLCM-D3-FIT
% save feature.mat AGFEATURE ARFEATURE GLRLMFEATURE GLDMFEATURE GLCMFEATURE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% b) using no fitted ROIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data preprocess: reconstruc, translate, and no fit.
% no fitted ROIS using:
% parameter.pixelSpacing = [.625,.625];
% parameter.reconstructMethod = 'linear';
% ROIS = reconstructRois(rois(:,8), rois(:,3),parameter.pixelSpacing,parameter.reconstructMethod,[-Inf Inf]); 
% ROIS = translateRois(ROIS,128,55,128,'hu2gray'); % the last parameter ishu2gray or translation

RSTFEATURE = extractTraditionalFeatures('RST',ROIS,parameter,[]); % RST, the corners of ROIS are nan values.
parameter.glh.numLevels = 92;
GLHFEATURE = extractTraditionalFeatures('GLH',ROIS,parameter,[]); % GLH, the corners of ROIS are nan values.
parameter.log.numLevels = 92;
parameter.log.absolution = 0 ;
parameter.log.way = 1;
COEFFLS = [ROIS logCoefficients(ROIS,parameter.grayLimits,[5 5],'integer',... % LOG, the corners of ROIS are nan values.
  parameter.interpolation,parameter.minEdge,parameter.log.way)];
LOGFEATURE = extractTraditionalFeatures('LOG',[],parameter,COEFFLS);

% load feature;
% save feature.mat AGFEATURE ARFEATURE GLRLMFEATURE GLDMFEATURE GLCMFEATURE RSTFEATURE GLHFEATURE LOGFEATURE

% FEATURE1= [RSTFEATURE GLHFEATURE GLCMFEATURE GLRLMFEATURE AGFEATURE ARFEATURE GLDMFEATURE LOGFEATURE];

%% 2) extract features using CMS-W
CS = COEFFWS;
CS(:,[1 5 9]) = []; % just for the detailed components

parameter.wrst.numLevels = 60; % the value isnot used for the NO DISCRETIZATION option
CMSWRSTFEATURE=extractTraditionalFeatures('CMS-WRST',[],parameter,CS); % NO DISCRETIZATION
parameter.whis.numLevels = 32;
CMSWHISFEATURE = extractTraditionalFeatures('CMS-WHIS',[],parameter,CS);
parameter.wcom.numLevels = 32;
parameter.wcom.distance = 2;
CMSWCOMFEATURE = extractTraditionalFeatures('CMS-WCOM',[],parameter,CS);
parameter.wrlm.numLevels = 16;
CMSWRLMFEATURE =  extractTraditionalFeatures('CMS-WRLM',[],parameter,CS);

% FEATURE2 = [CMSWRSTFEATURE CMSWHISFEATURE CMSWCOMFEATURE CMSWRLMFEATURE];

%% 3) extract features using CMS-C
CS = COEFFCS;
CS(:,[1 6]) = []; % just for the detailed components
parameter.crst.numLevels = 24; % the value isnot used for the NO DISCRETIZATION option
CMSCRSTFEATURE=extractTraditionalFeatures('CMS-CRST',[],parameter,CS);
parameter.chis.numLevels = 36;
CMSCHISFEATURE = extractTraditionalFeatures('CMS-CHIS',[],parameter,CS);
parameter.ccom.numLevels = 124;
parameter.ccom.distance = 3;
CMSCCOMFEATURE = extractTraditionalFeatures('CMS-CCOM',[],parameter,CS);
parameter.crlm.numLevels = 76;
CMSCRLMFEATURE =  extractTraditionalFeatures('CMS-CRLM',[],parameter,CS);

% FEATURE3 = [CMSCRSTFEATURE CMSCHISFEATURE CMSCCOMFEATURE CMSCRLMFEATURE];

%% 4) extract features using MSTA
MSTAWCOEFFS = [COEFFWS(:,2:4) COEFFWS(:,6:8) COEFFWS(:,10:12)]; % only use the detailed components
TRAMSTAWCOEFFS = MSTAWCOEFFS(li.traindices,:);
[parameter.mmw,parameter.mmw1,parameter.mmw2] = mmCoefficients(TRAMSTAWCOEFFS(li.tralabels==1,:),...
  TRAMSTAWCOEFFS(li.tralabels == 2,:),true,true,''); % absolution,mvmv,removeCorners

parameter.mstawrst.numLevels = 104;
MSTAWRSTFEATURE = extractMmTextureFeatures('MSTA-WRST',parameter,MSTAWCOEFFS);
parameter.mstawhis.numLevels = 36;
MSTAWHISFEATURE = extractMmTextureFeatures('MSTA-WHIS',parameter,MSTAWCOEFFS);
parameter.mstawcom.averaged = 1;
parameter.mstawcom.distance = 2;
parameter.mstawcom.numLevels = 44;
MSTAWCOMFEATURE = extractMmTextureFeatures('MSTA-WCOM',parameter,MSTAWCOEFFS);
parameter.mstawrlm.averaged = 1;
parameter.mstawrlm.numLevels= 20;
MSTAWRLMFEATURE= extractMmTextureFeatures('MSTA-WRLM',parameter,MSTAWCOEFFS);

% FEATURE5 = [MSTAWRSTFEATURE MSTAWHISFEATURE MSTAWCOMFEATURE MSTAWRLMFEATURE];

%% 5) extract features using MWCS
MWCSCOEFFS = maxabs({COEFFWS(:,2:4) COEFFWS(:,6:8) COEFFWS(:,10:12)});

% After reorganization，cols of 1, 2, and 3 are in the first-level decomposition, cols of 4, 5, and 6 are in the
% second-level decomposition, cols of 7, 8, and 9 are in the third-level decomposition. 
MWCSCOEFFS = MWCSCOEFFS(:,[1 4 7]); 

TRAMWCSCOEFFS = MWCSCOEFFS(li.traindices,:);
% TSTMWCSCOEFFS = MWCSCOEFFS(li.valindices,:);
[parameter.mmw,parameter.mmw1,parameter.mmw2] = mmCoefficients(TRAMWCSCOEFFS(li.tralabels == 1,:),...
  TRAMWCSCOEFFS(li.tralabels == 2,:),true,true,''); % absolution,mvmv,RemoveCorners

parameter.mwcsrst.numLevels = 20;
MWCSRSTFEATURE = extractMmTextureFeatures('MWCS-RST',parameter,MWCSCOEFFS);
parameter.mwcshis.numLevels = 52;
MWCSHISFEATURE = extractMmTextureFeatures('MWCS-HIS',parameter,MWCSCOEFFS);
parameter.mwcscom.averaged = 1;
parameter.mwcscom.distance = 3;
parameter.mwcscom.numLevels = 28;
MWCSCOMFEATURE = extractMmTextureFeatures('MWCS-COM',parameter,MWCSCOEFFS);
parameter.mwcsrlm.averaged = 1;
parameter.mwcsrlm.numLevels= 12;
MWCSRLMFEATURE= extractMmTextureFeatures('MWCS-RLM',parameter,MWCSCOEFFS);

% FEATURE6 = [MWCSRSTFEATURE MWCSHISFEATURE MWCSCOMFEATURE MWCSRLMFEATURE];

%% Train (10-fold cross-validation) and test
clear;clc;
load dataset li kv tc;
load feature MWCSCOMFEATURE; % change MWCSCOMFEATURE to another if train/test another feature set
FEATURE = MWCSCOMFEATURE; % change MWCSCOMFEATURE to another if train/test another feature set
[FEATURE,removedindices] = removeNanInfFeatures(FEATURE);
FEATURE = [FEATURE cell2mat(kv) cell2mat(tc)]; % kv/tc are added in the training
[TRN, TST] = normalizeAllFeatures(FEATURE,li,true);
subset = selectByLasso(TRN,li.tralabels,li.cvp,23,'MSE',1,true); % or try selectByIlfs, selectByMrmr
TRN = TRN(:,subset); 
TST = TST(:,subset); 
thresholds = 0:0.001:1;

%% Logistic Regression
% optimize hyperparameters
% r =  {distribution,link,modelspec,binomialSize,vauc,tauc};
best = optimizeLrParameters(TRN,TST,li);
parameter.lr.distribution = best{1};
parameter.lr.link = best{2};
parameter.lr.modelspec = best{3};
parameter.lr.binomialSize = best{4};

% train (10-fold cross-validation)
[trainedClassifier.lr, validationResult.lr] = trainLrClassifier(TRN,li.tralabels,li.cvp,...
  parameter.lr.distribution,parameter.lr.link,parameter.lr.modelspec,parameter.lr.binomialSize,true);
[accs,sens,specs]=varyThreshold(thresholds,validationResult.lr.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM LR: Indicator Values to Varied Thresholds' , '(validation results of 10-fold cross-validation)'});

% test
TSCORE=predict(trainedClassifier.lr,TST); TSCORE = [TSCORE 1-TSCORE];
testResult.lr = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.lr.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM LR: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear testClasses testScores ans kv1 kv2 ds accs sens spes specs TSCORE best;
save MWCS-COM

%% SVM linear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [classifier, valresult] = autoOptimizeSvmParameters(TRN,li.tralabels,li.cvp,'linear','gridsearch',true);
% [~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
% tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
% disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);
% clear classifier valresult TSCORE tstresult ans;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize with customized grid search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% r =  [kernelFunction,kernelScale,boxConstraint,standardize,polynomialOrder,vauc,tauc]
best = optimizeSvmParameters(TRN,TST,li,'linear',true,3);
parameter.svmlinear.kernelFunction = best{1};
parameter.svmlinear.kernelScale = best{2};
parameter.svmlinear.boxConstraint = best{3};
parameter.svmlinear.standardize = best{4};

% train (10-fold cross-validation)
% To obtain the reproducible result after retraining, it must in the same enviroment (machine, operation system, same seed,
% and in a parallel threading because the opitimization is performed in parallel threadings).
x = cell(1,3);
parfor i=1:1 
  rng(2109301813);  
  [parallelClassifier, parallelValidationResult] = trainSvmClassifier(TRN,li.tralabels,li.cvp,...
  parameter.svmlinear.kernelFunction,parameter.svmlinear.kernelScale,parameter.svmlinear.boxConstraint,...
  parameter.svmlinear.standardize,[],true);
  [~,TSCORE]=predict(parallelClassifier,TST);
  parallelTestResult = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
  disp(parallelValidationResult);
  disp(parallelTestResult);
  x(i,:) = {parallelClassifier,parallelValidationResult,parallelTestResult};
end
trainedClassifier.svmlinear = x{1};
validationResult.svmlinear = x{2};
[accs,sens,specs]=varyThreshold(thresholds,validationResult.svmlinear.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM SVM-LINEAR: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
[~,TSCORE]=predict(trainedClassifier.svmlinear,TST);
testResult.svmlinear = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.svmlinear.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM SVM-LINEAR: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear ans accs sens spes specs TSCORE best parallelClassifier x parallelValidationResult parallelTestResult;
save mwcs-com/MWCS-COM

%% LDA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [classifier, valresult] = autoOptimizeDaParameters(TRN,li.tralabels,li.cvp,'gridsearch');
% [~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
% tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
% disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);
% clear classifier valresult TSCORE tstresult ans;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize with customized grid search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% best is {discrimType,gamma,delta,prior,vauc,tauc}
best = optimizeDaParameters(TRN,TST,li,'linear');

parameter.lda.discrimType = best{1};
parameter.lda.gamma = best{2};
parameter.lda.delta = best{3};
parameter.lda.prior = best{4};

% train (10-fold cross-validation)
[trainedClassifier.lda, validationResult.lda] = trainDaClassifier(TRN,li.tralabels,li.cvp,...
  parameter.lda.discrimType,parameter.lda.gamma,parameter.lda.delta,parameter.lda.prior,true);
[accs,sens,specs]=varyThreshold(thresholds,validationResult.lda.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM LDA: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
[~,TSCORE]=predict(trainedClassifier.lda,TST);
testResult.lda = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.lda.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM LDA: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear testClasses testScores ans accs sens spes specs TSCORE best;
save MWCS-COM

%% ELDA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [classifier, valresult] = autoOptimizeEdaParameters(TRN,li.tralabels,li.cvp,'gridsearch',true);  
% [~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
% tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
% disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);
% clear classifier valresult TSCORE tstresult ans;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize with customized grid search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% r =  {discrimType,gamma,delta,subspaceDimension,numLearningCycles,prior,vauc,tauc}
best = optimizeEdaParameters(TRN,TST,li,'linear');
parameter.eda.discrimType = best{1};
parameter.eda.gamma = best{2};
parameter.eda.delta =  best{3};
parameter.eda.subspaceDimension =  best{4};
parameter.eda.numLearningCycles = best{5};
parameter.eda.prior = best{6};

% train (10-fold cross-validation)
% To obtain the reproducible result after retraining, it must in the same enviroment (machine, operation system, same seed,
% and in a parallel threading because the opitimization is performed in parallel threadings).
x = cell(1,3);
parfor i=1:1 
  rng(2109121232);  
  [parallelClassifier, parallelValidationResult] = trainEdaClassifier(TRN,li.tralabels,li.cvp,...
  parameter.eda.discrimType,parameter.eda.gamma,parameter.eda.delta,parameter.eda.subspaceDimension,...
  parameter.eda.numLearningCycles,parameter.eda.prior,true);
  [~,TSCORE]=predict(parallelClassifier,TST);
  parallelTestResult = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
  disp(parallelValidationResult);
  disp(parallelTestResult);
  x(i,:) = {parallelClassifier,parallelValidationResult,parallelTestResult};
end
trainedClassifier.eda = x{1};
validationResult.eda = x{2};
[accs,sens,specs]=varyThreshold(thresholds,validationResult.eda.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM ELDA: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
[~,TSCORE]=predict(trainedClassifier.eda,TST);
testResult.eda = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.eda.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM ELDA: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear testClasses testScores ans accs sens spes specs TSCORE best;
save MWCS-COM

%% SVM-RBF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [classifier, valresult] = autoOptimizeSvmParameters(TRN,li.tralabels,li.cvp,'rbf','gridsearch',true);
% [~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
% tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
% disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);
% clear classifier valresult TSCORE tstresult ans;

% r =  [kernelFunction,kernelScale,boxConstraint,standardize,polynomialOrder,vauc,tauc]
best = optimizeSvmParameters(TRN,TST,li,'rbf',true,3);
parameter.svmrbf.kernelFunction = best{1};
parameter.svmrbf.kernelScale = best{2};
parameter.svmrbf.boxConstraint = best{3};
parameter.svmrbf.standardize = best{4};

% train (10-fold cross-validation)
% To obtain the reproducible result after retraining, it must in the same enviroment (machine, operation system, same seed,
% and in a parallel threading because the opitimization is performed in parallel threadings).
x = cell(1,3);
parfor i=1:1 
  rng(2109301813);  
  [parallelClassifier, parallelValidationResult] = trainSvmClassifier(TRN,li.tralabels,li.cvp,...
  parameter.svmrbf.kernelFunction,parameter.svmrbf.kernelScale,parameter.svmrbf.boxConstraint,...
  parameter.svmrbf.standardize,[],true);
  [~,TSCORE]=predict(parallelClassifier,TST);
  parallelTestResult = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
  disp(parallelValidationResult);
  disp(parallelTestResult);
  x(i,:) = {parallelClassifier,parallelValidationResult,parallelTestResult};
end
trainedClassifier.svmrbf = x{1};
validationResult.svmrbf = x{2};
[accs,sens,specs]=varyThreshold(thresholds,validationResult.svmrbf.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM SVM-RBF: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
[~,TSCORE]=predict(trainedClassifier.svmrbf,TST);
testResult.svmrbf = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.svmrbf.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM SVM-RBF: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear ans accs sens spes specs TSCORE best parallelClassifier x parallelValidationResult parallelTestResult;
save MWCS-COM

%% Bayes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [classifier, valresult] = autoOptimizeBayesParameters(TRN,li.tralabels,li.cvp,'gridsearch');
% [~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
% tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
% disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);
% clear classifier valresult TSCORE tstresult ans;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize with customized grid search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% best is {distributionNames, width, kernel, prior,vauc,tauc}
best = optimizeBayesParameters(TRN,TST,li);
parameter.bayes.distributionNames = best{1};
parameter.bayes.width = best{2};
parameter.bayes.kernel = best{3};
parameter.bayes.prior = best{4};

% train (10-fold cross-validation)
[trainedClassifier.bayes, validationResult.bayes] = trainBayesClassifier(TRN,li.tralabels,li.cvp,...
  parameter.bayes.distributionNames,parameter.bayes.width,parameter.bayes.kernel,parameter.bayes.prior,true);
[accs,sens,specs]=varyThreshold(thresholds,validationResult.bayes.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.5 0.9],...
  {'MWCS-COM BAYES: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
[~,TSCORE]=predict(trainedClassifier.bayes,TST);
testResult.bayes = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.bayes.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.5 0.9],...
  {'MWCS-COM BAYES: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear ans accs sens spes specs TSCORE best parallelClassifier x parallelValidationResult parallelTestResult;
save MWCS-COM

%% PNN
% best is {'radbas',spread,vauc,tauc}
best = optimizePnnParameters(TRN,TST,li);
parameter.pnn.function = best{1};
parameter.pnn.spread = best{2};
% parameter.pnn.sigma = best{2};

% train (10-fold cross-validation)
[trainedClassifier.pnn, validationResult.pnn] = trainNewpnnClassifier(TRN,li.tralabels,li.cvp,parameter.pnn.spread,true);
% [trainedClassifier.pnn, validationResult.pnn] = trainPpnnClassifier(TRN,li.tralabels,li.cvp,parameter.pnn.sigma,true);
[accs,sens,specs]=varyThreshold(thresholds,validationResult.pnn.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.5 1],...
  {'MWCS-COM PNN: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
TSCORE = sim(trainedClassifier.pnn,TST')';
% [~,~,TSCORE] = parzenPNNclassify(trainedClassifier.pnn,TST',parameter.pnn.sigma);
testResult.pnn = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.pnn.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.5 1],...
  {'MWCS-COM PNN: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear ans accs sens spes specs TSCORE best parallelClassifier x parallelValidationResult parallelTestResult;
save MWCS-COM

%% ANN
% r =  {hiddenLayers,trainFcn,performFcn,hauc,vauc,tauc};
[best1,best2] = optimizeAnnParameters(TRN,TST,li,true);
best = best1;
parameter.ann.hiddenLayers = best{1};
parameter.ann.trainFcn = best{2};
parameter.ann.performFcn = best{3};

% train (10-fold cross-validation)
% To obtain the reproducible result after retraining, it must in the same enviroment (machine, operation system, same seed,
% and in a parallel threading because the opitimization is performed in parallel threadings).
x = cell(1,4);
parfor i=1:1 
  rng(2108282246);  
  [parallelClassifier, parallelValidationResult, parallelHoldoutValidationResult, ~] = ...
    trainAnnClassifier(TRN,li.tralabels,li.cvp,li.holdoutAnn,...
    parameter.ann.hiddenLayers,parameter.ann.trainFcn,parameter.ann.performFcn,true);
  TSCORE = parallelClassifier(TST')'; % the classifier was trained using a houldout way
  parallelTestResult = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
  disp(parallelValidationResult);
  disp(parallelTestResult);
  x(i,:) = {parallelClassifier,parallelValidationResult,parallelHoldoutValidationResult,parallelTestResult};
end
trainedClassifier.ann = x{1};
validationResult.ann = x{2};
validationResult.annHoldoutValidationResult = x{3};
[accs,sens,specs]=varyThreshold(thresholds,validationResult.ann.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.5 0.9],...
  {'MWCS-COM ANN: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
TSCORE = trainedClassifier.ann(TST')';
testResult.ann = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.ann.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.5 0.9],...
  {'MWCS-COM ANN: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear ans accs sens spes specs TSCORE best best1 best2 parallelClassifier x parallelValidationResult parallelTestResult;
save MWCS-COM

%% AdaBoostM1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [classifier, valresult] = autoOptimizeGbParameters(TRN,li.tralabels,li.cvp,'AdaBoostM1','gridsearch');
% [~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
% tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
% disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);
% clear classifier valresult TSCORE tstresult ans;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize with customized grid search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% best is r =  {impMethod,maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,...
%  splitCriterion,predictorSelection,numLearningCycles,learnRate,prior,vauc,tauc}.
best = optimizeGbParameters(TRN,TST,li,'AdaBoostM1');
parameter.adaboostm1.impMethod = best{1};
parameter.adaboostm1.maxNumSplits = best{2};
parameter.adaboostm1.minLeafSize = best{3};
parameter.adaboostm1.minParentSize = best{4};
parameter.adaboostm1.numVariablesToSample = best{5};
parameter.adaboostm1.splitCriterion = best{6};
parameter.adaboostm1.predictorSelection = best{7};
parameter.adaboostm1.numLearningCycles = best{8};
parameter.adaboostm1.learnRate = best{9};
parameter.adaboostm1.prior = best{10};

% train (10-fold cross-validation)
% To obtain the reproducible result after retraining, it must in the same enviroment (machine, operation system, same seed,
% and in a parallel threading because the opitimization is performed in parallel threadings).
x = cell(1,3);
parfor i=1:1 
  rng(2108280915);  
  [parallelClassifier, parallelValidationResult] = trainGbClassifier(TRN,li.tralabels,li.cvp,'AdaBoostM1',...
  parameter.adaboostm1.maxNumSplits,parameter.adaboostm1.minLeafSize,parameter.adaboostm1.minParentSize,...
  parameter.adaboostm1.numVariablesToSample,parameter.adaboostm1.splitCriterion,parameter.adaboostm1.predictorSelection,...
  parameter.adaboostm1.numLearningCycles,parameter.adaboostm1.learnRate,parameter.adaboostm1.prior,true);
  [~,TSCORE]=predict(parallelClassifier,TST);
  parallelTestResult = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
  disp(parallelValidationResult);
  disp(parallelTestResult);
  x(i,:) = {parallelClassifier,parallelValidationResult,parallelTestResult};
end
trainedClassifier.adaboostm1 = x{1};
validationResult.adaboostm1 = x{2};
[accs,sens,specs]=varyThreshold(thresholds,validationResult.adaboostm1.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM GBT-ABM1: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
[~,TSCORE]=predict(trainedClassifier.adaboostm1,TST);
testResult.adaboostm1 = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.adaboostm1.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM GBT-ABM1: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear ans accs sens spes specs TSCORE best parallelClassifier x parallelValidationResult parallelTestResult;
save MWCS-COM

%% GentleBoost
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [classifier, valresult] = autoOptimizeGbParameters(TRN,li.tralabels,li.cvp,'GentleBoost','gridsearch');
% [~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
% tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
% disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);
% clear classifier valresult TSCORE tstresult ans;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize with customized grid search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% best is r =  {impMethod,maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,...
%  splitCriterion,predictorSelection,numLearningCycles,learnRate,prior,vauc,tauc}.
best = optimizeGbParameters(TRN,TST,li,'GentleBoost');
parameter.gentleboost.impMethod = best{1};
parameter.gentleboost.maxNumSplits = best{2};
parameter.gentleboost.minLeafSize = best{3};
parameter.gentleboost.minParentSize = best{4};
parameter.gentleboost.numVariablesToSample = best{5};
parameter.gentleboost.splitCriterion = best{6};
parameter.gentleboost.predictorSelection = best{7};
parameter.gentleboost.numLearningCycles = best{8};
parameter.gentleboost.learnRate = best{9};
parameter.gentleboost.prior = best{10};

% train (10-fold cross-validation)
% To obtain the reproducible result after retraining, it must in the same enviroment (machine, operation system, same seed,
% and in a parallel threading because the opitimization is performed in parallel threadings).
x = cell(1,3);
parfor i=1:1 
  rng(2108280915);  
  [parallelClassifier, parallelValidationResult] = trainGbClassifier(TRN,li.tralabels,li.cvp,'GentleBoost',...
  parameter.gentleboost.maxNumSplits,parameter.gentleboost.minLeafSize,parameter.gentleboost.minParentSize,...
  parameter.gentleboost.numVariablesToSample,parameter.gentleboost.splitCriterion,parameter.gentleboost.predictorSelection,...
  parameter.gentleboost.numLearningCycles,parameter.gentleboost.learnRate,parameter.gentleboost.prior,true);
  [~,TSCORE]=predict(parallelClassifier,TST);
  parallelTestResult = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
  disp(parallelValidationResult);
  disp(parallelTestResult);
  x(i,:) = {parallelClassifier,parallelValidationResult,parallelTestResult};
end
trainedClassifier.gentleboost = x{1};
validationResult.gentleboost = x{2};
[accs,sens,specs]=varyThreshold(thresholds,validationResult.gentleboost.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM GBT-GB: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
[~,TSCORE]=predict(trainedClassifier.gentleboost,TST);
testResult.gentleboost = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.gentleboost.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM GBT-GB: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear ans accs sens spes specs TSCORE best parallelClassifier x parallelValidationResult parallelTestResult;
save MWCS-COM

%% LogitBoost
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [classifier, valresult] = autoOptimizeGbParameters(TRN,li.tralabels,li.cvp,'LogitBoost','gridsearch');
% [~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
% tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
% disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);
% clear classifier valresult TSCORE tstresult ans;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize with customized grid search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% best is r =  {impMethod,maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,...
%  splitCriterion,predictorSelection,numLearningCycles,learnRate,prior,vauc,tauc}.
best = optimizeGbParameters(TRN,TST,li,'LogitBoost');
parameter.logitboost.impMethod = best{1};
parameter.logitboost.maxNumSplits = best{2};
parameter.logitboost.minLeafSize = best{3};
parameter.logitboost.minParentSize = best{4};
parameter.logitboost.numVariablesToSample = best{5};
parameter.logitboost.splitCriterion = best{6};
parameter.logitboost.predictorSelection = best{7};
parameter.logitboost.numLearningCycles = best{8};
parameter.logitboost.learnRate = best{9};
parameter.logitboost.prior = best{10};

% train (10-fold cross-validation)
% To obtain the reproducible result after retraining, it must in the same enviroment (machine, operation system, same seed,
% and in a parallel threading because the opitimization is performed in parallel threadings).
x = cell(1,3);
parfor i=1:1 
  rng(2108280915);  
  [parallelClassifier, parallelValidationResult] = trainGbClassifier(TRN,li.tralabels,li.cvp,'LogitBoost',...
  parameter.logitboost.maxNumSplits,parameter.logitboost.minLeafSize,parameter.logitboost.minParentSize,...
  parameter.logitboost.numVariablesToSample,parameter.logitboost.splitCriterion,parameter.logitboost.predictorSelection,...
  parameter.logitboost.numLearningCycles,parameter.logitboost.learnRate,parameter.logitboost.prior,true);
  [~,TSCORE]=predict(parallelClassifier,TST);
  parallelTestResult = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
  disp(parallelValidationResult);
  disp(parallelTestResult);
  x(i,:) = {parallelClassifier,parallelValidationResult,parallelTestResult};
end
trainedClassifier.logitboost = x{1};
validationResult.logitboost = x{2};
[accs,sens,specs]=varyThreshold(thresholds,validationResult.logitboost.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM GBT-LB: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
[~,TSCORE]=predict(trainedClassifier.logitboost,TST);
testResult.logitboost = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.logitboost.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM GBT-LB: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear ans accs sens spes specs TSCORE best parallelClassifier x parallelValidationResult parallelTestResult;
save MWCS-COM

%% RF
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize automatically (grid search) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [classifier, valresult] = autoOptimizeRfParameters(TRN,li.tralabels,li.cvp,'gridsearch');
% [~,TSCORE]=predict(classifier,TST); % predictedLabels is not used
% tstresult = performance(li.vallabels,[],TSCORE,[1 2]);
% disp(['validation auc: ' num2str(valresult.auc) '; test auc: ' num2str(tstresult.auc)]);
% clear classifier valresult TSCORE tstresult ans;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% optimize with customized grid search %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% best is {maxNumSplits,minLeafSize,minParentSize,numVariablesToSample,...
%   splitCriterion,predictorSelection,numLearningCycles,prior,vauc,tauc}.
best = optimizeRfParameters(TRN,TST,li);
parameter.rf.maxNumSplits = best{1};
parameter.rf.minLeafSize = best{2};
parameter.rf.minParentSize = best{3};
parameter.rf.numVariablesToSample = best{4};
parameter.rf.splitCriterion = best{5};
parameter.rf.predictorSelection = best{6};
parameter.rf.numLearningCycles = best{7};
parameter.rf.prior = best{8};

% To obtain the reproducible result after retraining, it must in the same enviroment (machine, operation system, same seed,
% and in a parallel threading because the opitimization is performed in parallel threadings).
x = cell(1,3);
parfor i=1:1 
  rng(2108280913);  
  [parallelClassifier, parallelValidationResult] = trainRfClassifier(TRN,li.tralabels,li.cvp,...
    parameter.rf.maxNumSplits,parameter.rf.minLeafSize,parameter.rf.minParentSize,parameter.rf.numVariablesToSample,...
    parameter.rf.splitCriterion,parameter.rf.predictorSelection,parameter.rf.numLearningCycles,parameter.rf.prior,true);
  [~,TSCORE]=predict(parallelClassifier,TST);
  parallelTestResult = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
  disp(parallelValidationResult);
  disp(parallelTestResult);
  x(i,:) = {parallelClassifier,parallelValidationResult,parallelTestResult};
end
trainedClassifier.rf = x{1};
validationResult.rf = x{2};
[accs,sens,specs]=varyThreshold(thresholds,validationResult.rf.SCORE,li.tralabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM RF: Indicator Values to Varied Thresholds', '(validation results of 10-fold cross-validation)'});

% test
[~,TSCORE]=predict(trainedClassifier.rf,TST);
testResult.rf = performance(convertLabels(li.vallabels,[1 2],[1 0]),[],TSCORE,[1 0]);
[accs,sens,specs]=varyThreshold(thresholds,testResult.rf.SCORE,li.vallabels,[1 2]);
plotThresholds(thresholds, accs, sens, specs,[0.3 0.7],...
  {'MWCS-COM RF: Indicator Values to Varied Thresholds' , '(independent test results)'});

clear ans accs sens spes specs TSCORE best parallelClassifier x parallelValidationResult parallelTestResult;
save MWCS-COM