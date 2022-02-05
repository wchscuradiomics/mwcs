function [ci,meanAuc] = displayCi4Bootstraps(nBootstraps,seed,X,responses,classNames,trainedClassifier,method,tag,parameter)
% ci = displayCi4Bootstraps(nBootstraps,seed,X,responses,classNames,trainedClassifier,method,tag,parameter)
%
% A bootstrap takes n samples. 
% A row vector is a sample.
% responses must be a column vector.
% classNames muse be consistent with response.

if nargin == 7, tag = 'swr';parameter=[]; end 

responses = checkClassNames4BinaryClassification(classNames,responses);

if strcmpi(tag,'swr') % sampling with replacement 
  rng(seed);
  % IDX =  zeros(size(X,1),nBootstraps); % A bootstrap takes n samples and n equals size(X,1).  
  % for j=1:nBootstraps
  %   IDX(:,j) = bootstrap(1:size(X,1),size(X,1)); % the raw indices of the whole samples is 1:size(X,1)
  % end
  [~,IDX] = bootstrp(nBootstraps,[],(1:size(X,1))');  
  R = zeros(nBootstraps,4);
  for i=1:nBootstraps
    DS = X(IDX(:,i),:);
    labels = responses(IDX(:,i));
    % [~,TSCORE]=predict(trainedClassifier,DS);
    switch method
      case 'lr'
        TSCORE=predict(trainedClassifier.lr,DS); TSCORE = [TSCORE 1-TSCORE];
      case 'svmlinear'
        [~,TSCORE]=predict(trainedClassifier.svmlinear,DS);
      case 'lda'
        [~,TSCORE]=predict(trainedClassifier.lda,DS);  
      case 'eda'
        [~,TSCORE]=predict(trainedClassifier.eda,DS);
      case 'svmrbf'
        [~,TSCORE]=predict(trainedClassifier.svmrbf,DS);
      case 'bayes'
        [~,TSCORE]=predict(trainedClassifier.bayes,DS);
      case 'pnn'
        try
          TSCORE = sim(trainedClassifier.pnn,DS')';
        catch          
          [~,~,TSCORE] = parzenPNNclassify(trainedClassifier.pnn,DS',parameter.pnn.sigma);
        end
      case 'ann'
        TSCORE = trainedClassifier.ann(DS')';
      case 'dt'
        [~,TSCORE]=predict(trainedClassifier.dt,DS);        
      case 'adaboostm1'
        [~,TSCORE]=predict(trainedClassifier.adaboostm1,DS);
      case 'gentleboost'
        [~,TSCORE]=predict(trainedClassifier.gentleboost,DS);
      case 'logitboost'
        [~,TSCORE]=predict(trainedClassifier.logitboost,DS);
      case 'rf'
        [~,TSCORE]=predict(trainedClassifier.rf,DS);
      otherwise
        error('Invalid method.');
    end    
    % predictedClasses = classes2threshold(TSCORE,classNames,threshold);
    r = performance(labels,[],TSCORE,classNames);
    R(i,1) = r.auc;
    % R(i,2)= r.accuracy;
    % R(i,3)= r.sensitivity;
    % R(i,4)= r.specificity;
  end 
  
  m = mean(R); meanAuc = m(1);
  s = std(R);
  ci = calci(m(1),s(1),nBootstraps,0.05);
  % disp(['AUC = ' num2str(m(1),'%5.4f') ' (' num2str(ci(1),'%5.4f') '-' num2str(ci(2),'%5.4f') ')']);
  % ci = calci(m(2),s(2),nBootstraps);
  % disp(['Accuracy = ' num2str(m(2),'%4.3f') ' (' num2str(ci(1),'%4.3f') '-' num2str(ci(2),'%4.3f') ')']);  
elseif strcmpi(tag,'cross-validation') 
  % % way 1: boostrap
  % rng(seed);
  % [~,IDX] = bootstrp(nBootstraps,[],(1:size(X,1))');
  % R = zeros(nBootstraps,4);
  % for i=1:nBootstraps
  %   % [~,validationResult] = trainLrClassifier(X,responses,kfold,parameter);
  %   switch method
  %     case 'lr'
  %       DS = X(IDX(:,i),:);
  %       labels = responses(IDX(:,i));
  %       cvp = cvpartition(labels,'KFold',10);
  %       [~, validationResult] = trainLrClassifier(DS,labels,cvp,...
  %         parameter.lr.distribution,parameter.lr.link,parameter.lr.modelspec,parameter.lr.binomialSize,false);
  %     case 'svmlinear'
  %       [~, validationResult] = trainSvmClassifier(DS,labels,cvp,...
  %         parameter.svmlinear.kernelFunction,parameter.svmlinear.kernelScale,parameter.svmlinear.boxConstraint,...
  %         parameter.svmlinear.standardize,[],true);
  %     otherwise
  %       error('Invalid method.');
  %   end
  %
  %   % predictedClasses = classes2threshold(validationResult.SCORE,classNames,threshold);
  %   R(i,1)= validationResult.auc;
  %   % R(i,2)= validationResult.accuracy;
  %   % R(i,3)= validationResult.sensitivity;
  %   % R(i,4)= validationResult.specificity;
  % end
  % m = mean(R); meanAuc = m(1);
  % s = std(R);
  % ci = calci(m(1),s(1),nBootstraps,0.05);
  
  % way 2: Hanley and McNeil (1982)
  switch method
    case 'lr'
      auc=trainedClassifier.lr.auc;
    case 'svmlinear'
      auc=trainedClassifier.svmlinear.auc;
    case 'lda'
      auc=trainedClassifier.lda.auc;
    case 'eda'
      auc=trainedClassifier.eda.auc;
    case 'svmrbf'
      auc=trainedClassifier.svmrbf.auc;
    case 'bayes'
      auc=trainedClassifier.bayes.auc;
    case 'pnn'
      auc=trainedClassifier.pnn.auc;
    case 'ann'
      auc=trainedClassifier.ann.auc;
    case 'dt'
      auc=trainedClassifier.dt.auc;
    case 'adaboostm1'
      auc=trainedClassifier.lr.adaboostm1.auc;
    case 'gentleboost'
      auc=trainedClassifier.gentleboost.auc;
    case 'logitboost'
      auc=trainedClassifier.logitboost.auc;
    case 'rf'
      auc=trainedClassifier.rf.auc;
    otherwise
      error('Invalid method.');
  end
  ci = calhmci(auc,1.96,sum(responses==classNames(1)),sum(responses==classNames(2)));
  
  % disp(['AUC = ' num2str(m(1),'%5.4f') ' (' num2str(ci(1),'%5.4f') '-' num2str(ci(2),'%5.4f') ')']);
  % ci = calci(m(2),s(2),nBootstraps);
  % disp(['Accuracy = ' num2str(m(2),'%4.3f') ' (' num2str(ci(1),'%4.3f') '-' num2str(ci(2),'%4.3f') ')']);  
end