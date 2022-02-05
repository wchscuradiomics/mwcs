function subset = selectFeatureIndicesBySdt(F1,F2)
%Select features by statistical difference tests using u/t test and coefficient of variation

if size(F1,2) ~= size(F2,2)
  error 'column sizes of FeP and FeN must be same.';
end

[p,~] = mwu(F1,F2); % u test
% [~,p] = ttest2(F1,F2);
% meanp = mean(F1);
% meann = mean(F2);
stdp = std(F1);
stdn = std(F2);
% cvp = stdp./ meanp;
% cvn = stdn./meann;
% subset = find(p<=0.05 & cvp <= 0.15 & cvn <= 0.15);
subset = find(p<=0.01 & stdp <= 0.5 & stdn < 0.5);