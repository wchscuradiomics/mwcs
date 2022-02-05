%% 
clear;clc;
% load('mwcs-com/mwcs-com.mat','MWCSCOMFEATURE', 'li');
load('mwcs-com/mwcs-com.mat'); 
FEATURE = MWCSCOMFEATURE;
[FEATURE,removedIndices] = removeNanInfFeatures(FEATURE); % 原特征集中第187、196列无效，被删除
FEATURE = [FEATURE cell2mat(kv) cell2mat(tc)]; % kv/tc are added in the training
% [TRN, TST] = normalizeAllFeatures(FEATURE,li,true); % 不能使用规范化的值，不好比较大小

ST = FEATURE(li.valindices,subset); % 注意FEATURE是从原209个特征中删除第187、196列后获得的
[p,~,~] = mwu(ST(li.vallabels == 1,:),ST(li.vallabels==2,:),'both');
statisticalIndices = find(p<=0.01);
disp(subset(statisticalIndices)); 
clear p h ans p1 p2 p3 p4 stats;

%% 处理索引
validIndices = 1:209;
validIndices(removedIndices) = [];

%% COM特征排列
% 令n为从一个共生矩阵中指定的一个距离提取的特征数 （已计算4个方向均值）, n通常为5或者23，则特征排列为：
% f = [d=1(1:n) d=2(1:n) ...]
% MSTA提取特征则为 [分量1的f 分量2的f ...]

featureNames = cell(1,length(statisticalIndices));

%% index=64,在原特征矩阵中也是列索引也是64，level-1 (每级别一个分量，有23*d=69个特征，其中d=3)
% d=3,每个距离23个特征，因此index=64处于d=3的特征中且是第index-23*2 = 18个特征，即Maximum Probability
% The “maximum probability” of GLCM measures the probability of co-occurrence pairs with the most frequent type, which
% usually appear around the intensity edge or the uniform interface. 
% Fu J, Fang M J, Dong D, et al. Heterogeneity of metastatic gastrointestinal stromal tumor on texture analysis: DWI
% texture as potential biomarker of overall survival[J]. European journal of radiology, 2020, 125: 108825.
featureNames{1} = {'level-1, d=3', 'Maximum probability'}; % 'level-1, d=3, maximum probability'

%% index=82,,在原特征矩阵中也是列索引也是82，level-2 (每级别一个分量，有23*d=69个特征，其中d=3)
% d=1,每个距离23个特征，因此index=82处于d=1的特征中且是第index-23*1 = 13个特征，即Second Informaiton measure of correlation 
% IMC2 also assesses the correlation between the probability distributions of (i) and (j) (quantifying the complexity of
% the texture). Therefore, the range of IMC2 = [0, 1), with 0 representing the case of 2 independent distributions (no
% mutual information) and the maximum value representing the case of 2 fully dependent and uniform distributions (maximal
% mutual information). (not necessarily uniform; low complexity; i.e., low IMC2)
featureNames{2} = {'level-2, d=1', 'Information measure of correlation 2'} ; % 'level-2, d=1,information measure of correlation 2';

%% index=157,在原特征矩阵中也是列索引也是157，level-3
% 157-23*3*2 = 19, d = 1, i.e., inverse difference, Homogeneity in matlab
% ID (a.k.a. Homogeneity 1) is another measure of the local homogeneity of an image. With more uniform gray levels, the
% denominator will remain low, resulting in a higher overall value (即值特征值越高).
featureNames{3} = {'level-3, d = 1', 'Inverse difference'};

%% index=167, 在原特征矩阵中也是列索引也是157，level-3
%  167-23*3*2 = 29, d=2, 第29-23=6个特征，i.e., sum average
% SumAverage measures the relationship between occurrences of pairs with lower intensity values and occurrences of pairs
% with higher intensity values. Measures the mean of the gray level sum distribution of the image.
featureNames{4} = {'level-3, d=2', 'Sum average'};

%% index=188, 在原特征矩阵中也是列索引是189，level-3
%  189-23*3*2 = 51, d=3, 第51-23*2=5个特征，i.e., inverse difference moment
% IDM (a.k.a Homogeneity 2) is a measure of the local homogeneity of an image. IDM weights are the inverse of the Contrast
% weights (decreasing exponentially from the diagonal i=j in the GLCM).
%  Inverse Difference Moment (IDM) is the local homogeneity. It is high when local gray level is uniform and inverse GLCM
%  is high.
featureNames{5} = { 'level-3, d=3', 'Inverse difference moment'}; %  'level-3, d=3, inverse difference moment';

%% index=204, 在原特征矩阵中也是列索引是206，level-3
% 206-23*3*2 = 68, d=3, 第68-23*2=22个特征, i.e., Renyi entropy
featureNames{6} = {'level-3, d=3', 'Renyi entropy'};

%% 计算AUCs
stats = cell(1,length(statisticalIndices));
aucs =zeros(1,length(statisticalIndices));
sides = {'left','right','left','right','left','right'};
pvalues = zeros(1,length(statisticalIndices));

nx = sum(li.vallabels == 1);
ny = sum(li.vallabels == 2);
for i=1:length(statisticalIndices)
  [pmwc,~,stat] = mwu(ST(li.vallabels == 1,statisticalIndices(i)),ST(li.vallabels==2,statisticalIndices(i)),sides{i});
  pvalues(i) = pmwc;
  u =stat{1}.ranksum-nx*(nx+1)/2;
  if strcmpi(sides{i},'left'), u  = nx*ny-u; end
  aucs(i) = u/(nx*ny);
  
  % stats{i}=mwwtest(ST(li.vallabels == 1,statisticalIndices(i))',ST(li.vallabels==2,statisticalIndices(i))');
  % if strcmpi(sides{i},'left')
  %   aucs(i) = stats{i}.U(1) / (sum(stats{i}.U));
  % else
  %   aucs(i) = stats{i}.U(2) / (sum(stats{i}.U));
  % end
  % disp(aucs(i));
end
clear i ans pmwc stat u;

%% box plots
set(0,'DefaultAxesFontName','Gulliver','DefaultTextFontName','Gulliver','DefaultLegendFontName','Gulliver',...
  'DefaultAxesFontSize',9,'DefaultTextFontSize',10,'DefaultLegendFontSize',10,'DefaultLegendFontSizeMode','manual',...
  'DefaultTextFontSizeMode','manual');

for i=1:length(statisticalIndices)
  subplot(2,3,i);
  boxplot([ST(li.vallabels == 1,statisticalIndices(i)),ST(li.vallabels==2,statisticalIndices(i))],...
    'Notch','on','Labels',{'HCC','HEM'},'Colors','bg');
  title([['p<=' num2str(pvalues(i),'%5.4f') ' '  featureNames{i}{1}],  {featureNames{i}{2}}]); % '; AUC=' num2str(AUC2,'%5.4f')
end
clear i ans;
