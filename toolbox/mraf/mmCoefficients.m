% [mm,mm1,mm2] = mmCoefficients(COEFF1S,COEFF2S,absolution,mvmv,option) calculate mean mins and mean maxs or minimum mins
% and maximum maxs.
% 
%  COEFF1S is a n1*m cell, where n1 is the number of samples (class 1) and m is the number of components.
%  COEFF2S is a n2*m cell, where n2 is the number of samples (class 2).
%  absolution is a boolean specifying whether the coefficient matrices will be absoluted.
%  mvmv is a boolean that the true value specifying "mean mins and mean maxs" are calculated, otherwise "minimum mins and
%  maximum maxs" are calculated.
%  option: 'RemoveCorners' or 'none', specifying whether the corners are removed.
%