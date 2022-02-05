% GRAYCOPROPS Properties of gray-level run-length matrix.
%   -------------------------------------------
%   STATS = GRAYCOPROPS(GLRLM,PROPERTIES) Each element in  GLRLM, (r,c),
%    is the probability occurrence of pixel having gray level values r, run-length c in the image.
%    GRAYCOPROPS is to calculate PROPERTIES.
%   -------------------------------------------
%   Requirements:
%   -------------------------------------------
%    GLRLM mustbe an cell array of valid gray-level run-length
%    matrices.Recall that a valid glrlm must be logical or numerical.
%   -------------------------------------------
%   Current supported statistics include:
%   -------------------------------------------
%    Short Run Emphasis (SRE)
%    Long Run Emphasis (LRE)
%    Gray-Level Nonuniformity (GLN)
%    Run Length Nonuniformity (RLN)
%    Run Percentage (RP)
%    Low Gray-Level Run Emphasis (LGRE)
%    High Gray-Level Run Emphasis (HGRE)
%    Short Run Low Gray-Level Emphasis (SRLGE)
%    Short Run High Gray-Level Emphasis (SRHGE)
%    Long Run Low Gray-Level Emphasis (LRLGE)
%    Long Run High Gray-Level Emphasis (LRHGE)
%   --------------------------------------------
%   Reference:
%   --------------------------------------------
%    Xiaoou Tang,Texture Information in Run-Length Matrices
%    IEEE TRANSACTIONS ON IMAGE PROCESSING, VOL.7, NO.11,NOVEMBER 1998
%  ---------------------------------------------
%   See also GRAYRLMATRIX.
%  ---------------------------------------------
%  Author:
%  ---------------------------------------------
%     (C)Xunkai Wei <xunkai.wei@gmail.com>
%     Beijing Aeronautical Technology Research Center
%     Beijing %9203-12,10076
%  ---------------------------------------------
%  History:
%  ---------------------------------------------
%  Creation: beta         Date: 01/10/2007
%  Revision: 1.0          Date: 12/11/2007
%  1.Accept cell input now
%  2.Using MATLAB file style
%  3.Fully vectorized programming
%  4.Fully support the IEEE reference
%  5. ...
%