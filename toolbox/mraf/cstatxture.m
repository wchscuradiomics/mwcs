% Calculate statistical measures of texture in an image.
% 
%  I: an image with grayscale [1 nLevels].
% 
%  nLevels: the grayscale of I.
% 
%  f: a row vector representing the histogram features of I.
% 
%  f(1) = Average gray level f(2) = Average contrast f(3) = Measure of smoothness f(4) = Skewness. It
%  can be replaced by the third moment (but divide (L-1)^2, where L == n ie grayscale is [1 n]). The
%  third moment is not equal to skewness, but plays the same role to skewness. f(5) = Measure of
%  uniformity f(6) = Entropy f(7) = Kurtosis. It can be replaced by the fourth moment (but divide
%  (L-1)^2, where L == n ie grayscale is [1 n]). The fourth moment is not equal to kurtosis, but
%  plays the same role to kurtosis. f(8-12) = percentage of [0.01 0.10 0.50 0.90 0.99]
% 
%  Note: In the previous version, t(4) = Third moment and t(7) = Fourth moment ("Minus 3"), but in
%  this version, they have been replaced to skewness and kurtosis respectively since 2019/13/10.
%