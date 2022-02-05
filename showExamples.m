clear;clc;
load base rois;

%% show delineation
roi = rois(152,:);
I = dicom2gray(roi{1},256);
figure,imshow(I);
hold on;
[B,L] = bwboundaries(roi{2},'noholes');
boundary = B{1};
plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 1.5);

%%
imshow(double(I).*roi{2},[0 255])
imshow(roi{8},[])
ROI = dicomReconstruct(roi{8},roi{3},[0.625 0.625],[-Inf Inf],1,'linear');
imshow(dicomReconstruct(roi{8},roi{3},[0.625 0.625],[-Inf Inf],1,'linear'),[]);
imshow(hu2gray(ROI,128,55,128) + 1,[1 128]);
% OI = hu2gray(ROI,128,55,128) + 1;
OI = ROIS{152};
OI = OI - 1;
% OI = mat2gray(OI,[0 127]);
% dwtmode('zpd','nodisplay');
% [c, s]= wavedec2(OI,3,'rbio3.1');
% wave2gray(c,s,256);