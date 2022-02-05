function masks = segrois(directory,c)
%Segment ROIs from D:\Matlab\Published\20-0675\Delineated\HCC or D:\Matlab\Published\20-0675\Delineated\HEM

files = dir([directory '\*.bmp']);
masks = cell(size(files,1),2);
for i=1:size(files,1)
  masks{i,1} = [files(i).folder '\' replace(files(i).name,'.bmp','.dcm')];
  
  Bmp = imread([files(i).folder '\' files(i).name]);
  RedChannel = Bmp(:, :, 1);
  GreenChannel = Bmp(:, :, 2);
  BlueChannel = Bmp(:, :, 3);
  Edge = RedChannel == 0 & GreenChannel == 255 & BlueChannel == 55;
  M = imfill(Edge, 'holes');
  M(Edge) = 0;
  masks{i,2} = M;
  copyfile(masks{i,1},[c '\' replace(files(i).name,'.bmp','.dcm')]);
end