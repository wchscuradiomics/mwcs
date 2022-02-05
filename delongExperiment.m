clear;clc;
load roc;
load('base-roialong.mat', 'li');
x = 19;
ratings = zeros(x,100); % 50 HCC and 50 HEM
spsizes = [50 50];
for i=1:19
  S = scoreTransform(thresholds{i,8});
  S = S(:,1);
  S1 = S(li.vallabels == 1);
  S2 = S(li.vallabels == 2);
  ratings(i,:) = [S1;S2]';
end

clear i ans x S S1 S2;
save delong

%% perform DeLong's tests
clear;clc;
load delong;
% DeLongUserInterface;
x1 = [1 6 10 16]; 
x2 = [2 7 11 17];
x3 = [3 8 12 18];
x4 = [4 9 13 19];
% disp(lgnames(x4))

p1 = [0.0764 0.8650 0.0269];
p2 = [0.0054 0.0209 0.0001];
p3 = [0.3867 0.2256 0.0702];
p4 = [0.5304 0.5032 0.0054];

x = [x1;x2;x3;x4];
p = [p1;p2;p3;p4];

%% plot DeLong's tests
lgnames = cell(length(thresholds),1);
for i=1:length(thresholds)
  lgnames{i} = [thresholds{i,7} 10 'AUC=' num2str(thresholds{i,6},'%4.3f')];  
end

styles = {'r:','g-.','b--','k-'};
v = x(4,:);
pv = p(4,:);
for i=1:length(v)
  plot(thresholds{v(i),3},thresholds{v(i),4},styles{i},'LineWidth',1);hold on;
  if i< 4
    lgnames{v(i)} = [lgnames{v(i)} ' p<=' num2str(pv(i),'%5.4f')];
  end
end
clear i ans;

title('DeLong''s tests (RLM)');
xlabel('False Positive Rate (1-Specificity)');
ylabel('True Positive Rate (Sensitivity)');
legend(lgnames(v));

