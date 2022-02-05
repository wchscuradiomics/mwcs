% Extract 48 ACM Features using Sobel operator (filter) [3] from a pair of co-occurrence matrices
% (DCM and MCM).
% 
%  C: an image (or subimage/coefficient matrix) that will be discretized into the parameter sequence
%  accroding the parameter edges, and gradient matrices D (direction) and M (magnitude) will be
%  calculated based on C.
% 
%  edges: a row vector representing the discretization edges. If the parameter edges is empty, no
%  discretization on C (the grayscale range of C is already [1 nLevels]).
% 
%  sequence: a vector listing the values of the discretized elements of C.
% 
%  nLevels: an integer specifying the number of gray levels to use when scaling the grayscale values
%  in D and M.
% 
%  d: an integer spcifying the distance of co-occurrence matrices. For example, d = 3 means the
%  distance from 1 to 3.
% 
%  isAveraged: a bool value representing 4 directions whether averaged.
% 
%  fd: a row vector representing the features of the direction gradient co-occurrence matrix.
% 
%  fm: a row vector representing the features of the magnitude gradient co-occurrence matrix.
% 
%  ACMD: a matrix representing the angle co-occurrence matrix in direction gradient.
% 
%  ACMM: a matrix representing the angle co-occurrence matrix in magnitude gradient.
% 
%  [1] Gabor filter; [2] Wavelet filter; [3] Sobel filter; [4] used Sobel filter.
% 
%  [1] Chakraborty J, Rangayyan R M, Banik S, et al. Statistical measures of orientation of texture
%  for the detection of architectural distortion in prior mammograms of interval-cancer[J]. Journal
%  of Electronic Imaging, 2012, 21(3): 033010.
% 
%  [2] Chakraborty J, Rangayyan R M, Banik S, et al. Detection of architectural distortion in prior
%  mammograms using statistical measures of orientation of texture[C]// Medical Imaging 2012:
%  Computer-Aided Diagnosis. International Society for Optics and Photonics, 2012, 8315: 831521.
% 
%  [3] Chakraborty J, Midya A, Mukhopadhyay S, et al. Automatic characterization of masses in
%  mammograms[C]// 2013 6th International Conference on Biomedical Engineering and Informatics. IEEE,
%  2013: 111-115.
% 
%  [4] Chakraborty J, Langdon-Embry L, Cunanan K M, et al. Preliminary study of tumor heterogeneity
%  in imaging predicts two year survival in pancreatic cancer patients[J]. PloS one, 2017, 12(12):
%  e0188022.
%