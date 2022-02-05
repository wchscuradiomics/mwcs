%% 合并所有特征
% FEATURE= [FEATURE1 FEATURE2 FEATURE3 FEATURE4];

%% 只合并各个组内选定的特征
% FEATURE = [FEATURE1(:,subset1) FEATURE2(:,subset2) FEATURE3(:,subset3) FEATURE4(:,subset4)];
FEATURE = [FEATURE2(:,subset2) FEATURE4(:,subset4)];

%% 特征预选
% TRN = FEATURE(li.traindices,:);
% F1 = TRN(li.tralabels == 1,:);
% F2 = TRN(li.tralabels == 2,:);
% presubset = selectFeatureIndicesBySdt(F1,F2);

%% 特征选择
ds = normalizeAllFeatures(FEATURE,li,true);
[TRN,TST,subset] = selectByLasso(ds(:,1),kv,li.traindices,li.valindices,li.tralabels,'MSE',li.cvp,1,236);
% [TRN,TST,subset] = selectBySortedLasso(ds(:,1),kv,li.traindices,li.valindices,li.tralabels,'MSE',li.cvp,1,236,0.18);
%  [TRN,TST,subset] = selectByIlfs(ds(:,1),kv,li.traindices,li.valindices,li.tralabels,3);
% [TRN,TST,subset] = selectByMrmr(ds(:,1),kv,li.traindices,li.valindices,li.tralabels);

TRNL =[TRN li.tralabels];