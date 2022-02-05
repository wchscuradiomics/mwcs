function f=extractSubbandMaxabsFeatures(C,way)
%Extract 7 raw statistical texture features. There is no influence if C contains NaN values.
%
% C: an image (or subimage/coefficient matrix).
%
% f: a row vector representing the extracted features.
%
% This funciton usually used on the no-discritized coefficient matrix. C can be absoluted or
% un-absoluted.
%
% Note: C is converted to a vector to extract features and not used as a 2D matrix; moments in a 2D
% matrix express geometric characteristics such as size, position, orientation, and shape, etc; if c
% is a vector, the third-order center moment and  the fourth-order center moment are express
% skewness and kurtosis (can be viewed as both textures and geometric characteristics),
% respectively.

if nargin == 1
  way = 1;
end

C = double(C(:));
C(isnan(C)) = [];

if way == 1
  C(abs(C)<=1e-5)=[];
  C = abs(C);
  f = extractDescriptors(C);
elseif way == 2
  C1 = C(C > 0);
  C2 = - C(C < 0);
  f = [extractDescriptors(C1) extractDescriptors(C2)];
end

end

function f = extractDescriptors(C)
n = length(C);
f1 = sum(C)/n; % the first-order original moment, i.e. mean
f2 = sum(C.^2)/n; % the second-order original moment, i.e. energy or uniformaity
% f3 = sum(C.^3)/n; % the third-order original moment, it's similar to f2. f4 = sum(C.^4)/n; % the
% fourth-order original moment, it's similar to f2. the first-order center moment is 0
m2 = sum((C-f1).^2)/n; % the second-order center moment, i.e. variance
f5 = sqrt(m2); % standard deviation 
m3 = sum((C-f1).^3)/n; % the third-order center moment, it means more in histogram.
m4 = sum((C-f1).^4)/n; % the fourth-order center moment, it means more in histogram.
f6 = m3/(m2^1.5); % skewness
f7 = m4/(m2^2)-3; % kurtosis. "Minus 3" is to make the kurtosis of the normal distribution 0
f8 = 1 - 1/(1+m2); % smooth
f9 = -sum(C.*log2(C))/n;

% widely used statistics f8 = 1-1/(1+m2/(gl(2)-gl(1))^2); % smooth, it means more in histogram.
% contrast, homogeneity, etc. are not meaning here due to i and j are not gray-level, they are
% positions. indices = find(C>0); nIndices = length(indices); f9 =
% -sum(C(indices).*log2(C(indices)))/length(indices);  % entropy, it means more in histogram.

f=[f1 f2 f5 f6 f7 f8 f9];
end