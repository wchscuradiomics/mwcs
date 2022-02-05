%  EXTEND2   2D extension
% 
% 	y = extend2(x, ru, rd, cl, cr, extmod)
% 
%  Input:
% 	x:	input image
% 	ru, rd:	amount of extension, up and down, for rows
% 	cl, cr:	amount of extension, left and rigth, for column
% 	extmod:	extension mode.  The valid modes are:
% 		'per':		periodized extension (both direction)
% 		'qper_row':	quincunx periodized extension in row
% 		'qper_col':	quincunx periodized extension in column
% 
%  Output:
% 	y:	extended image
% 
%  Note:
% 	Extension modes 'qper_row' and 'qper_col' are used multilevel
% 	quincunx filter banks, assuming the original image is periodic in 
% 	both directions.  For example:
% 		[y0, y1] = fbdec(x, h0, h1, 'q', '1r', 'per');
% 		[y00, y01] = fbdec(y0, h0, h1, 'q', '2c', 'qper_col');
% 		[y10, y11] = fbdec(y1, h0, h1, 'q', '2c', 'qper_col'); 
% 		
%  See also:	FBDEC
%