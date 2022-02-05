%% 计算面积
% clear;clc;
% load base;
% 
% areas = zeros(size(rois,1),1);
% for i=1:size(rois,1)
%   % ps = rois{i,3};
%   areas(i) = sqrt(size(rois{i,8},1)*rois{i,3}(1)*size(rois{i,8},2)*rois{i,3}(2));
% end
% clear i ans;

%% 计算年龄 性别 设备 管电压 管电流
clc;
ages = zeros(size(rois,1),1);
genders = cell(size(rois,1),1);
devices = cell(size(rois,1),1); % 不应该纳入检验，本来就需要不同设备之间的泛化能力，因此要求训练集和测试集中设备有差异
kvps= zeros(size(rois,1),1);
xtcs= zeros(size(rois,1),1);
exposureTimes = zeros(size(rois,1),1);
slices = zeros(size(rois,1),1);
dates = cell(size(rois,1),1);
for i=1:size(rois,1)
  info = dicominfo(rois{i,1});
  PatientAge '060Y'
  PatientSex 'F' 'M'
  DeviceSerialNumber
  ExposureTime: 500
  ManufacturerModelName
  if isfield(info,'DeviceSerialNumber'), disp([info.DeviceSerialNumber info.ManufacturerModelName]); end
    ages(i) = str2double(replace(info.PatientAge,'Y',''));
    genders{i} = info.PatientSex;
    devices{i} = info.ManufacturerModelName;
    kvps(i) = info.KVP;
    xtcs(i) = info.XRayTubeCurrent;
    slices(i) = info.SliceThickness; % 5mm 325个; 7mm 11个
  dates{i} = info.SeriesDate;
  try
    exposureTimes(i) = info.ExposureTime;
  catch
  end
end
clear i info ans;

%% 将集合属性（训练集、测试集）转换成categorical变量
tt = NaN(length(li.labels),1);
tt(li.traindices) = 1;
tt(li.valindices) = 2;

%% 差异检验
% 连续变量用u检验（原假设为均值相等）
% 分类变量用卡方检验（原假设为两个分类变量之间没有非随机关联,即原假设为两个分类变量是独立的），或
% Fisher确切检验（原假设为两个分类变量之间没有非随机关联）
% 目标：不能拒绝原假设

p = ranksum(ages(li.traindices),ages(li.valindices)); % 年龄 p=0.8020
disp([num2str(mean(ages(li.traindices))) '±' num2str(std(ages(li.traindices)))]);
disp([num2str(mean(ages(li.valindices))) '±' num2str(std(ages(li.valindices)))]);
% 49.7161±10.3878
% 50.21±9.5052

p = ranksum(areas(li.traindices),areas(li.valindices)); % 肿瘤面积 p=0.3291
disp([num2str(mean(areas(li.traindices))) '±' num2str(std(areas(li.traindices)))]);
disp([num2str(mean(areas(li.valindices))) '±' num2str(std(areas(li.valindices)))]);
% 44.0192±22.5325
% 40.8037±18.1258

genders = categorical(genders);
[~,p,~] =  fishertest(crosstab(tt,genders)); % 性别 p = 0.6229, h=0
% [~,~,p,~] = crosstab(tt,genders);
% 90   146 row 1: training set
% 35    65 row 2: test set
% in training set, 90 females, 146 males; in test set, 35 feamale, 65 males

% devices = categorical(devices);
% [~,~,p,~] = crosstab(tt,devices); % chi test
% 26    88     5     1     4    62    50 row 1: training set
% 7    47     0     0     2    23    21 row 2: test set

p = ranksum(kvps(li.traindices),kvps(li.valindices)); % KVP p=0.9149
disp([num2str(mean(kvps(li.traindices))) '±' num2str(std(kvps(li.traindices)))]);
disp([num2str(mean(kvps(li.valindices))) '±' num2str(std(kvps(li.valindices)))]);
% 115.5932±8.9006
% 115.6±8.3267

p = ranksum(xtcs(li.traindices),xtcs(li.valindices)); % XTC 0.4788
disp([num2str(mean(xtcs(li.traindices))) '±' num2str(std(xtcs(li.traindices)))]);
disp([num2str(mean(xtcs(li.valindices))) '±' num2str(std(xtcs(li.valindices)))]);
% 290.5805±81.4659
% 294.12±70.9335

temps = exposureTimes(exposureTimes~=0);
exposureTimes(exposureTimes==0) = mean(temps);
clear temps ans;
p = ranksum(exposureTimes(li.traindices),exposureTimes(li.valindices)); % Exposure Times  0.3067
disp([num2str(mean(exposureTimes(li.traindices))) '±' num2str(std(exposureTimes(li.traindices)))]);
disp([num2str(mean(exposureTimes(li.valindices))) '±' num2str(std(exposureTimes(li.valindices)))]);
% 543.5456±71.7009
% 542.0572±60.7324