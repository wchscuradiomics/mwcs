% Compute boundaries for coefficients of two types.
% [B,B1,B2] = boundaries2(COEFF1S,COEFF2S,absolution)
% 
%  COEFF1S: a n1*m cell of coefficient matrices for type 1, where n1 is the sample size for type 1
%  and a row vector contains m coefficient matrices for a sample.
% 
%  COEFF2S: a n2*m cell of coefficient matrices for type 2, where n2 is the sample size for type 2
%  and a row vector contains m coefficient matrices for a sample.
% 
%  absolution: a logical value specifying whether absolute coefficients are used.
% 
%  B: a 2*m matrix representing the boundaries of m components basing COEFF1S and COEFF2S.
% 
%  B1: a 2*m matrix representing the boundaries of m components basing COEFF1S.
% 
%  B2: a 2*m matrix representing the boundaries of m components basing COEFF2S.
% 
%  In B/B1/B2, the first row stores the average values of minimums, the second row stores the average
%  values of maximums.
%