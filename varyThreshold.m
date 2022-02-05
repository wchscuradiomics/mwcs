function [accs,sens,specs]=varyThreshold(t,scores,labels,classNames)

if sum(scores(:)>1)>0 || sum(scores(:)<0)>0
  for i=1:size(scores,1)
    scores(i,:)= softmax(scores(i,:)')';
  end
end

np = sum(labels==classNames(1)); % 阳性（正）样本类数量
nn = sum(labels==classNames(2)); % 阴性（负）样本类数量

len = length(t);
accs = zeros(len,1);
sens = zeros(len,1);
specs = zeros(len,1);

for i=1:length(t)
  class = repmat(classNames(2),[length(labels) 1]);
  class(scores(:,1) >= t(i)) = classNames(1);
  tp = sum(class == classNames(1) & labels == classNames(1));
  tn = sum(class == classNames(2) & labels == classNames(2));
  accs(i) = (tp+tn)/(np+nn);
  sens(i) = tp/np;
  specs(i) = tn/nn;
end

