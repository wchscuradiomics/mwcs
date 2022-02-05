% [trainedClassifier, validationResult] = autoOptimizeSvmParameters(DS,labels,cvp,kernelFunction,optimizer,parallel)  
% optimize hyperparemeters of SVM automaticlly.
% 
%  fitcsvm ��������
%  
%    BoxConstraint - fitcsvm ������������������� [1e-3,1e3]�
%  
%    KernelScale - fitcsvm ������������������� [1e-3,1e3]�
%  
%    KernelFunction - fitcsvm � 'gaussian'�'linear' � 'polynomial' ����
%  
%    PolynomialOrder - fitcsvm � [2,4] ����������
%  
%    Standardize - fitcsvm � 'true' � 'false' ����
% 
%  optimizer: bayesopt | gridsearch | bayesopt | randomsearch
%