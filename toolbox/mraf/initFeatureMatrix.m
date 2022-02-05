% [FEATURE,nf,initialized] = initFeatureMatrix(nSamples,nComponents,p) initialize a nSamples*(size(p,2)*nComponents) 
% feature matrix.
% 
%  nSample: an integer specifying the number of samples.
%  nComponents: an integer specifying the number of components.
%  p: a column vector specifying the number of features for a component of a sample. If no components are needed, set
%  nComponents to 1.
%