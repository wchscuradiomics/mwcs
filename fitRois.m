function FROIS=fitRois(ROIS,nLevels,way)
%Fit nan values of ROIs to make the ROIs as rectangular ROIs. 
%FROIS=fitRois(ROIS,nLevels)
%
% The grayscale of an ROI is [1 nLevels].
% A fitted ROI with a grayscale of [1 nLevels].

if nargin == 2
  way = 'InpaintExemplar';
end

FROIS = cell(size(ROIS));

if strcmpi(way,'InpaintExemplar')
fillOrder = 'gradient'; % 'gradient' (default) | 'tensor'
for i=1:length(FROIS)  
  I = ROIS{i};
  M = isnan(I);
  I=mat2gray(I,[1 nLevels]);
  I(M) = 0;
  try
    F = inpaintExemplar(I,M,'FillOrder',fillOrder);
    % F = inpaintCoherent(I,M,'Radius',5);    
  catch
    try
      F = inpaintExemplar(I,M,'PatchSize',[5 5],'FillOrder',fillOrder);
      % F = inpaintCoherent(I,M,'Radius',3);
    catch
      try
        F = inpaintExemplar(I,M,'PatchSize',[3 3],'FillOrder',fillOrder);
        % F = inpaintCoherent(I,M,'Radius',3);
      catch ex
        error(['i=' num2str(i) ', sn=' FROIS{i,4} ': ' ex.message]);
      end
    end
  end
  % F = round(F);
  % F(F < gl(1)) = gl(1);
  % F(F > gl(2)) = gl(2);
  F(F < 0) = 0;
  F(F > 1) = 1;
  F = round(F*nLevels);
  F(F<1)=1;
  FROIS{i} = F;
end
elseif strcmpi(way, 'FillNaN')
  for i=1:length(ROIS)
    ROI = ROIS{i};
    ROI(isnan(ROI)) = 1;
    FROIS{i} = ROI;
  end
end
