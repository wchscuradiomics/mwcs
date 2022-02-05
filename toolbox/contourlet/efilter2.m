%  EFILTER2   2D Filtering with edge handling (via extension)
% 
% 	y = efilter2(x, f, [extmod], [shift])
% 
%  Input:
% 	x:	input image
% 	f:	2D filter
% 	extmod:	[optional] extension mode (default is 'per')
% 	shift:	[optional] specify the window over which the 
% 		convolution occurs. By default shift = [0; 0].
% 
%  Output:
% 	y:	filtered image that has:
% 		Y(z1,z2) = X(z1,z2)*F(z1,z2)*z1^shift(1)*z2^shift(2)
% 
%  Note:
% 	The origin of filter f is assumed to be floor(size(f)/2) + 1.
% 	Amount of shift should be no more than floor((size(f)-1)/2).
% 	The output image has the same size with the input image.
% 
%  See also:	EXTEND2, SEFILTER2
%