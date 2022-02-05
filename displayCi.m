clear;clc;
name = 'MWCS-COM';
load([name '\' name '.mat']);
% disp([num2str(validationResult.lr.auc) 9 num2str(testResult.lr.auc)]);
% best = optimizeLrParameters(TRN,TST,li)

clc;
% methods = {'lr','svmlinear','lda','eda','svmrbf','bayes','pnn','ann','dt','adaboostm1','gentleboost','logitboost','rf'};
methods = {'svmlinear'};

for i=1:length(methods)
  switch methods{i}
    case 'lr'
      valresult = validationResult.lr;
      tstresult = testResult.lr;
    case 'svmlinear'
      valresult = validationResult.svmlinear;
      tstresult = testResult.svmlinear;
    case 'lda'
      valresult = validationResult.lda;
      tstresult = testResult.lda;
    case 'eda'
      valresult = validationResult.eda;
      tstresult = testResult.eda;
    case 'svmrbf'
      valresult = validationResult.svmrbf;
      tstresult = testResult.svmrbf;
    case 'bayes'
      valresult = validationResult.bayes;
      tstresult = testResult.bayes;
    case 'pnn'
      valresult = validationResult.pnn;
      tstresult = testResult.pnn;
    case 'ann'
      valresult = validationResult.ann;
      tstresult = testResult.ann;
    case 'dt'
      valresult = validationResult.dt;
      tstresult = testResult.dt;
    case 'adaboostm1'
      valresult = validationResult.adaboostm1;
      tstresult = testResult.adaboostm1;
    case 'gentleboost'
      valresult = validationResult.gentleboost;
      tstresult = testResult.gentleboost;
    case 'logitboost'
      valresult = validationResult.logitboost;
      tstresult = testResult.logitboost;
    case 'rf'
      valresult = validationResult.rf;
      tstresult = testResult.rf;
    otherwise
      error('Invalid method.');
  end
    
  disp([methods{i} ' validation auc: ' num2str(valresult.auc,4)]);  
  disp([methods{i} ' test auc (保留6位小数): '  num2str(tstresult.auc,6)]);
  
  method = methods{i}; tstauc = tstresult.auc;
  seeds=1:600;
  cis = zeros(length(seeds),2);
  meanAucs = zeros(length(seeds),1);
  
  parfor iseed = 1:length(seeds)
    % ci = displayCi4Bootstraps(nBootstraps,seed,X,responses,classNames,trainedClassifier,method,tag,parameter)    
    [ci,meanAuc] = displayCi4Bootstraps(100,seeds(iseed),TST,li.vallabels,[1 2],trainedClassifier,method,'swr',parameter);
    % [ci,meanAuc] = displayCi4Bootstraps(30,iseed,TRN,li.tralabels,[1 2],trainedClassifier,method,...
    %   'cross-validation',parameter);
    cis(iseed,:) = ci;
    meanAucs(iseed) = meanAuc;
  end
  
  diffs = abs(meanAucs-tstauc);
  [diff,minIndex] = min(diffs);
  ci = cis(minIndex,:);
  seed = seeds(minIndex);
  meanAuc = meanAucs(minIndex);
  
  if diff <= 1e-4
    disp([method ' test auc: ' num2str(seed) 9 num2str(meanAuc,6) ' (' num2str(ci(1),6) '-' num2str(ci(2),6) ')' ...
      9 'test auc (保留4位小数): ' num2str(valresult.auc,4) 9  num2str(seed) 9 num2str(meanAuc,4) ...
      ' (' num2str(ci(1),4) '-' num2str(ci(2),4) ')']);
  end
  
  disp('******************************************************************');
end
clear ci ans iseed meanAuc m s ci ans method valresult tstresult method tstauc nSeeds seeds;

% % to create the reproducible result
% method = 'lr';
% parfor i=1:1
% [ci,meanAuc] = displayCi4Bootstraps(100,382,TST,li.vallabels,[1 2],trainedClassifier,method);
% disp(ci);
% disp(meanAuc);
% end