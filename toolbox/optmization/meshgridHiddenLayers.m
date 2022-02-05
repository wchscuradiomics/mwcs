% M = meshgridHiddenLayers(v,n) create hidden layers for patternnet. A row vector of M is an eligible value of the parameter 'hiddenSizes' for patternnet. Then
% length of M(i,:) is the number of hidden layers.
% 
%  The number of neures for the i-th layer can not be larger than the number of neures for the (i-1)-th layer.
%  v is a vector, of which an element specifies the potential number of neures in each hidden layer.
%