function AUC = calauc(trainedClassifier,DS,labels,classNames)

TSCORE=predict(trainedClassifier.lr,DS); TSCORE = [TSCORE 1-TSCORE];
r = performance(labels,[],TSCORE,classNames);
AUC = r.auc;