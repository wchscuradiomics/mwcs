%%
clear;clc;
mats = {'MWCS-COM\MWCS-COM','CMS-WRST\CMS-WRST','MSTA-WCOM\MSTA-WCOM','LOG\LOG'};
curves = table('Size',[length(mats) 4],'VariableTypes',{'cell','cell','double','char'},...
  'VariableNames',{'fprates','tprates','aucs','names'}); % 
spsizes = [50 50];
ratings = zeros(length(mats),100);

for i=1:length(mats)
  load(mats{i},'testResult');
  tstresult = testResult.gentleboost;
  curves.fprates{i} = tstresult.fprates;
  curves.tprates{i} = tstresult.tprates;
  curves.aucs(i) = tstresult.auc;
  curves.names{i} = mats{i}(strfind(mats{i},'\')+1:end);
  SCORE= tstresult.SCORE;
  if ~isProbabilityMatrix(SCORE)
    for j=1:size(SCORE,1)
      SCORE(j,:)= softmax(SCORE(j,:)')';
    end
  end
  ratings(i,:) = SCORE(:,1)';
end
clear i j tstresult testResult SCORE ans;
save roc-gbtgb.mat;
% DeLongUserInterface
%%
clear;clc;
load roc-svmlinear

set(0,'DefaultAxesFontName','Gulliver','DefaultTextFontName','Gulliver','DefaultLegendFontName','Gulliver',...
  'DefaultAxesFontSize',9,'DefaultTextFontSize',10,'DefaultLegendFontSize',10,'DefaultLegendFontSizeMode','manual',...
  'DefaultTextFontSizeMode','manual');

% a='rgbck'; % rgbcmyk
% b='.ox+*sdv^<>ph'; % '.ox+*sdv^<>ph'
% c={'-',':','-.','--'}; % {'-',':','-.','--'}

lines={'k-','r:','g-.','b--','c-<'};
legendNames = cell(1,size(curves,1));

% k=0;
% for i=1:4
%   for j=1:4
%     k = k + 1;
%     styles{k} = [a(i) c{j}];
%   end
% end
% styles = [styles;{'k-','k:','k-.','k--'}'];
% styles{16} = styles{20};
% 

for i=1:size(curves,1)
  hold on;
  plot(curves.fprates{i},curves.tprates{i},lines{i},'LineWidth',2.5-i*0.5);
  legendNames{i} = [curves.names{i} ' AUC=' num2str(curves.aucs(i),'%5.4f')];
end

title({'ROC curves of independent', 'tests using SVM-RBF'},'fontSize',11);
xlabel('Horizontal Axis: FPR'); % False Positive Rate (1-Specificity)
ylabel('Vertical Axis: TPR'); % True Positive Rate (Sensitivity)
hleg=legend(legendNames);
clear i ans;
