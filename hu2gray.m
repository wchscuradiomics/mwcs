function I = hu2gray(MODALITY,nLevels,windowCenter,windowWidth)

w = windowWidth - 1.0;
c = windowCenter - 0.5;
T = ((MODALITY - c)/w + 0.5) * (nLevels - 1);
MASK1 = MODALITY <= c - 0.5*w; % 0
MASK2 = MODALITY > c + 0.5*w; % nLevels-1;
T(MASK1) = 0;
T(MASK2) = nLevels-1;  

if nLevels==256
  I = uint8(T);
elseif nLevels == 65536
  I = uint16(T);
else
  I = round(double(T));
end
