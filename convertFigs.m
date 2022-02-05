clear;clc;
% folders = {'AG','AR','CMS-CCOM','CMS-CHIS','CMS-CRLM','CMS-CRST','CMS-WCOM','CMS-WHIS','CMS-WRLM','CMS-WRST',...
%   'GLCM','GLDM','GLH','GLRLM','LOG','MSTA-WCOM','MSTA-WHIS','MSTA-WRLM','MSTA-WRST',...
%   'MWCS-COM','MWCS-HIS','MWCS-RLM','MWCS-RST','RST'};
folders={'MWCS-COM'};

directory = 'd:\figs';

for f = 1:length(folders)
  if exist(fullfile(directory,folders{f}),'dir')==0
    mkdir(fullfile(directory,folders{f}));
  end
  
  figs = dir(fullfile(folders{f},'\*.fig'));
  for i=1:length(figs)
    if ~contains(figs(i).name,'DT','IgnoreCase',false)
      fig2tif(fullfile(figs(i).folder,figs(i).name),fullfile(directory,folders{f},replace(figs(i).name,'.fig','.tif')));
    end
  end
end
clear i f ans;