%% 诺模图
clear;clc;
load('mwcs-com/mwcs-com.mat');
classifier = trainedClassifier.svmlinear;
scores = testResult.svmlinear.SCORE; % any sum for a row of SOCRE must equal to 1

orders = TST; % the data to be inputted
X = zeros(size(orders));
for i=1:size(X,2) % standardize data
  X(:,i) = (orders(:,i)-classifier.Mu(i))*classifier.Beta(i)/(classifier.Sigma(i)*classifier.KernelParameters.Scale);
end
% for i=1:size(X,2) % standardize data
%   X(:,i) = I(:,i)*classifier.Beta(i)/classifier.KernelParameters.Scale;
% end
rs =  sum(X,2)+classifier.Bias;

% 绘制总分轴并计算/获取相关基础参数
% 确定总分范围：1-csigmoid(s,slope,intercept)对应了第1类的概率，改变总评分s的值，
% 观察s取值范围为多少时第1类概率范围接近[0 1]。
% MWCS-COM：s取[-5 5]时，第1类的概率范围接近[0 1]。
% 为了进一步缩小s的范围，总评分s一般取每个测试样本计算出总评分后->组成的向量的最大最小值
tpoints = [min(rs): (max(rs)-min(rs))/5 : max(rs) - classifier.Bias]';
slope = -1.124594e+00; intercept = -1.343106e-01; % 根据svmlinear classifier的ScoreTransform可以得到
uh = 30;

% 开始绘制总分轴并设置基础绘制参数
hi = 2*uh;
plot(tpoints,hi*ones(1,length(tpoints)),'k','LineWidth',0.5)
set(gca,'xtick',tpoints)
xlim([tpoints(1)-3 tpoints(end)+1.5]);
textx = tpoints(1)-1.3;
set(gca,'ytick',[],'Ycolor','w','box','off')
drawScale(tpoints,hi);
text(textx,hi,'Total Points');
ylim([0 13*uh+10]);

% 开始绘制评分轴,与总分轴基本相同
hi = 12*uh;
plot(tpoints,hi*ones(1,length(tpoints)),'k','LineWidth',0.5)
set(gca,'xtick',tpoints)
xlim([tpoints(1)-3 tpoints(end)+1.5]);
drawScale(tpoints,hi);
text(textx,hi,'Points');

% 开始绘制概率轴
xprobabilities = 1-csigmoid(tpoints+classifier.Bias,slope,intercept);
% probabilities = min(xprobabilities) : (max(xprobabilities) - min(xprobabilities))/8 : max(xprobabilities);
probabilities = [min(xprobabilities) 0.02 0.05 0.1 0.2 0.4 0.6 0.8 0.9 0.96 max(xprobabilities)];
xprobabilities = (log(1./(1-probabilities)-1)-intercept)/slope;
hi = 1*uh;
plot(xprobabilities,hi*ones(1,length(xprobabilities)),'k','LineWidth',0.5)
drawScale(xprobabilities,hi,probabilities);
text(textx,hi,'Probabilities');

% 绘制第i个变量of X
variableNames = {'x1','x2','x3','x4','x5','x6','x7','x8','x9'};
for i=1:size(TST,2)
  plotxipoints(TST(:,i),classifier.Mu(i),classifier.Sigma(i),classifier.Beta(i),classifier.KernelParameters.Scale,...
    5, [min(tpoints) max(tpoints)] ,(12-i)*uh,textx,variableNames{i});
end

% clear i x hi uh X Rs probs Trnc Trsc I xrang x9rang x10rang x11rang x12rang ans textx pointb;

% for i=1:size(xlines,2)
%   hold on;
%   
%   % if abs(max(X(:,i)) - min(X(:,i))) > 0.05
%   x = xlines(1,i):((xlines(2,i)-xlines(1,i))/3):xlines(2,i);
%   if ~ (abs (x(end) - xlines(2,i)) <= 0.5)
%     x = [x xlines(2,i)];
%   end 
%   plot(x,(hi-uh*i)*ones(1,length(x)),...
%     'k','LineWidth',0.5); 
%   drawScale(x,hi-uh*i);
% end

%% 校准曲线
scores = testResult.svmlinear.SCORE(:,1);
[scores,orders]=sort(scores);
vallabels = checkClassNames4BinaryClassification([1 0],li.vallabels(orders));

predictedProbs=zeros(4,1);
actualProbs=zeros(4,1);
k=1;
queue = 1:round(length(orders)/4):length(orders);
for i=1:length(queue)  
  if i < length(queue), inds = queue(i):(queue(i+1)-1); else, inds = queue(i):length(orders); end 
  actualProbs(k)=sum(vallabels(inds))/length(inds);
  predictedProbs(k)=mean(scores(inds));
  k=k+1;
end
clear i k ans si index B I;

figure,
plot(predictedProbs,actualProbs,'k-*','lineWidth',1);
xlim([0 1]);ylim([0 1])
hold on;
plot(0:0.2:1,0:0.2:1,'b--.');

y=actualProbs';
Y=predictedProbs';
Rf = 1-sum((y-Y).^2)/sum((Y-mean(Y)).^2); % 0.9908

xlabel('Nomogram estimated probability for HCC');
ylabel('observed fraction probability for HCC');