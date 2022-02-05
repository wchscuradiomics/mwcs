% Extract 5 raw statistical texture features. There is no influence if C contains NaN values.
% 
%  C: an image (or subimage/coefficient matrix).
% 
%  f: a row vector representing the extracted features.
% 
%  This funciton usually used on the no-discritized coefficient matrix. C can be absoluted or
%  un-absoluted.
% 
%  Note: C is converted to a vector to extract features and not used as a 2D matrix; moments in a 2D
%  matrix express geometric characteristics such as size, position, orientation, and shape, etc; if c
%  is a vector, the third-order center moment and  the fourth-order center moment are express
%  skewness and kurtosis (can be viewed as both textures and geometric characteristics),
%  respectively.
%