% Convert labels to binary matrix. A row vector is a sample.
% 
%  labels: a column vector of m*1, which means m samples.
% 
%  B: a binary/logical matrix of m*length(unique(labels)) representing labels, where the position of
%  the true value in the i-th row represents the category of the i-th sample.
%