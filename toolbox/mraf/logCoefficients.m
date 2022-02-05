% Calculate coefficients of Laplacian of Gaussian filters. A coefficient matrix falls into [1 nLevels].
% COEFFS = logCoefficients(ROIS,limits,hsize,dataType,interpolation,minsi,way)
% 
%  ROIS: a n*1 cell, an ROI is a matrix.
% 
%  limits: [limits(1) limits(2)] specifying the grayscale of an ROI.
% 
%  hsize: a 1*2 vector spcifying the sizes of the filters.
% 
%  COEFFS: a n*5 cell representing the filtered subband images.
% 
%  If elements of an ROI are integers, the grayscale of the ROI must be [1 nLevels]. If an ROI is
%  double or single, the grayscale of the ROI must be [0 1]. The default filter size is [5 5]. Five
%  filters are used (sigma=0.5,1,1.5,2,2.5). Log filters usually combine histogram to extract
%  features because filtered images contain fine or coase textures.
% 
%  Note:
%  1) The grayscale of an ROI is [1 nLevels], thus, this function is different from functions of
%  waveletCoefficients/... (their ROIS are not assigned grayscales);
% 
%  2) However, the third-party toolboxes assigned the grayscales of ROIS, so this function achieved
%  the function of the third-party toolboxes, thus, the grayscale of all the subband images is also
%  [1 nLevels];
% 
%  3) Actually, we also achived another function clogCoefficients that their ROIS are not assigned
%  grayscales;
% 
%  4) This function has not used the original image as a subband image, because the grayscale of the
%  original image is [1 nLevels], if histogram features are extracted from the original image, these
%  features are the same as the features extracted by function
%  extractSubbandHistogramFeatures(OriginalImage,[],[],nLevels);
% 
%  5) Some studies used LoG + Histogram to extract features, we need to read if a study used the
%  original image to extract histogram features, which decides whether combining the features
%  extracted based on this function (logCoefficients) and the features extracted based on the
%  original image.
% 
%  6) In general, logCoefficients is more commonly used. Because in the MSTA architecture, when LoG
%  is used as a similar multi-resolution analysis method, its ability is far inferior to wavelet
%  transform, Gabor transform, or Fourier transform and other time-frequency transform methods;
%  moreover, in the CMS architecture, the features of clogCoefficients+wcodemat+histogram are close
%  to the features of directly using logCoefficients+histogram. In other words, if the MSTA
%  architecture is used, the multi-resolution analysis capability of clogCoefficients is
%  insufficient, so it can be ignored; if the CMS architecture is used, the features obtained based
%  on clogCoefficients are close to the features obtained based on the direct use of logCoefficients.
%