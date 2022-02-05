function sampledIndices = bootstrap(rawIndices,n)
%sampledIndices = bootstrap(rawIndices,n) performs sampling with replacement.
%
% rawIndicws: the raw indices of the whole samples in which n samples will be picked out.

m=length(rawIndices); 
randomOrders= ceil(m*rand(1,n)) ; % generate n random index between 1 and m
sampledIndices = rawIndices(randomOrders) ; % sampling