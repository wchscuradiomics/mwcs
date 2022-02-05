%% 检查纳入日期
% files = dir('Delineated\HEM\*.dcm'); % 更换为HCC\*.dcm可检查HCC纳入日期
% dates = cell(size(files,1),1);
% for i=1:size(files,1)
%   info = dicominfo([files(i).folder '\' files(i).name]);
%   dates{i} = info.StudyDate;
% end
% clear i ans;
% dates= sort(dates);

%% 获得ROI及其对应的DCM文件的URL
% hcc = segrois('D:\Matlab\Published\20-0675\Delineated\HCC','D:\Matlab\riw\Delineated\HCC');
% hem = segrois('D:\Matlab\Published\20-0675\Delineated\HEM','D:\Matlab\riw\Delineated\HEM');
% % clc;
% % for i=8:8
% %   figure,imshow(masks{i,2});
% % end
% % clear i ans a files info dates;
% 
% hcc = modify(hcc);
% hem = modify(hem);

% for i=1:length(hcc)
%   hcc{i,1} = replace(hcc{i,1},'D:\Matlab\Published\20-0675\Delineated\','');
% end
% clear i ans;
% 
% for i=1:length(hem)
%   hem{i,1} = replace(hem{i,1},'D:\Matlab\Published\20-0675\Delineated\','');
% end
% clear i ans;

%% 补充HEM
% % convertFolders('E:\HEM\HEM林补充第1批PlainCT文件夹名.mat',privateKey);
% C = readcell('D:\Matlab\riw\HEM林补充第1批PlainCT文件夹名.xlsx');
% % load('D:\Matlab\riw\Delineated\HEM\HEMIDs.mat');
% % ids =[ids; C];
% % save('D:\Matlab\riw\Delineated\HEM\HEMIDs.mat','ids');
% privateKey='MIIBVQIBADANBgkqhkiG9w0BAQEFAASCAT8wggE7AgEAAkEAz0Eh/0g2Spl2umg4PNJ0vx9c+iRBv2oASod2kzoOAEL1D1rj+OPof1O5K6ytucPBC2Mj7BCUrSWTzjVBM6CG7wIDAQABAkEAtX/ztu1VZlUo7avxfApOZUWhFgqEbY31/U7OX7aapkxo7wNyiMtAul16CDenlAwoaBpjo379lgcnhQAuZ/g/AQIhAPLpNy9VyiPq0ecezASnjqQRP48BTtg1PsvxjTOsnpNvAiEA2mwPZ08rOnMo4Z+I7+wxKMBocZPC54wryUi9UrH9hIECIDbqQm+RFYHJNGrrq3Ph7X1p6NSLlyeJ4gh5M1LbU35BAiEAjrUZn1MPmGHTbQ6yBqfYOprz4nk7V9OybBG1eMlILYECIEHVr1K80KWYLMnfu6yIuzVxaubm/Bilw8ap4UJvS7RQ';
% 
% files = dir('E:\HEM\*.mat');
% for i=1:length(files)
%   load([files(i).folder '\' files(i).name]);
%   info = dicominfo(item.path);
%   id = rsaDescryptedString2PlainText(char(rsaDecrypt(char(info.PatientID), privateKey)));
%   a = str2double(C{find(strcmpi(C(:,1),id)),2}); 
%   disp(a);
%   hem{a,1} = ['HEM\' num2str(a,'%04d') '.dcm'];  
%   copyfile(item.path,['D:\Matlab\riw\Delineated\' hem{a,1}]);
%   hem{a,2} = item.MASK;
%   hem{a,3} = info.PixelSpacing;
%   hem{a,4} = info.KVP;
%   SV = double(dicomread(['D:\Matlab\riw\Delineated\' hem{a,1}]));
%   MODALITY = info.RescaleSlope * SV + info.RescaleIntercept;
%   hem{a,5} = MODALITY;
%   [rs,re,cs,ce] = boundBox(hem{a,2});
%   hem{a,6} = MODALITY(rs:re,cs:ce);
%   MODALITY(~hem{a,2}) = nan;
%   hem{a,7} = MODALITY(rs:re,cs:ce);
% end
% clear i a ans rs re cs ce SV MODALITY info id;

%% 显示感兴趣区
% I = dicom2gray(hcc{120,1},256,45,200);
% figure,imshow(I);
% hold on;
% [B,L] = bwboundaries(hcc{120,2},'noholes');
% boundary = B{1};
% plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1.5);
% % plot(item.positions, 'w', 'LineWidth',
% clear B boundary I L ans;

%% 补充管电流
% XrayTubeCurrent
% for i=1:length(rois)
%   info = dicominfo(rois{i,1});
%   try
%   rois{i,5} = info.XRayTubeCurrent;
%   catch ex
%     disp('');
%   end
% end
% clear i info ans;