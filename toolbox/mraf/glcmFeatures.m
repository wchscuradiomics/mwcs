% Calculate 23 GLCM features from 4 references.
%  The maximal correlation coefficient was not calculated due to computational instability.
%  http://murphylab.web.cmu.edu/publications/boland/boland_node26.html
% 
%  GLCMS: a 3-D matrix specifying co-occurrence matrices. (a GLCM in GLCMS need not be normalized.)
% 
%  out: a structure specifying the extracted features.
%  Energy (angular second moment): [1,1)] [2,1)], abbreviation of uniformity of energy
%  Contrast: [1,2)] [2,2)]
%  Correlation: [1,3)] [2,3)] % the chinese name is wrong in baidu baike
%  Sum of sqaures (variance): [1,4)]
%  Homogeneity (inverse difference moment): [1, 5)] [2,4)]
%  Sum average: [1,6)]
%  Sum variance: [1,7)]
%  Sum entropy: [1,8)]
%  Entropy: [1,9)] [2,5)]
%  Difference variance: [1,10)]
%  Difference entropy: [1,11)]
%  Information measure of correlation1: [1,12)]
%  Informaiton measure of correlation2: [1,13)]
%  Maximal correlation coefficient: [1, 14)] long calculation time % was not calculated due to computational instability
%  Autocorrelation: [2,6)]
%  Dissimilarity: [2,7)]
%  Cluster Shade: [2,8)]
%  Cluster Prominence: [2,9)]
%  Maximum probability: [2,10)]
%  Inverse difference (Homogeneity in matlab, in fact, homogeneity is inverse difference moment): [3]
%  Inverse Difference Moment Normalized [3]
%  Inverse Difference Normalized [3]
%  Renyi entropy [4]
%  Tsallis entropy [5]
% 
%  References:
%  1. R. M. Haralick, K. Shanmugam, and I. Dinstein, Textural Features for Image Classification, IEEE
%  Transactions on Systems, Man and Cybernetics, vol. SMC-3, no. 6, Nov. 1973
% 
%  2. L. Soh and C. Tsatsoulis, Texture Analysis of SAR Sea Ice Imagery Using Gray Level
%  Co-Occurrence Matrices, IEEE Transactions on Geoscience and Remote Sensing, vol. 37, no. 2, March
%  1999.
% 
%  3. D A. Clausi, An analysis of co-occurrence texture statistics as a function of grey level
%  quantization, Can. J. Remote Sensing, vol. 28, no. 1, pp. 45-62, 2002
% 
%  4. Banik S, Rangayyan RM, Desautels JE. Measures of angular spread and entropy for the detection
%  of architectural distortion in prior mammograms. International Journal of Computer assisted
%  Radiology and Surgery. 2013; 8(1):121±134. https://doi.org/10.1007/s11548-012-0681-x PMID:
%  22460365
% 
%  5. Yang X, Tridandapani S, Beitler JJ, Yu DS, Yoshida EJ, Curran WJ, et al. Ultrasound GLCM
%  texture analysis of radiation-induced parotid-gland injury in head-and-neck cancer radiotherapy:
%  An in vivo study of late toxicity. Med Phys. 2012; 39(9):5732±5739.
%  https://doi.org/10.1118/1.4747526 PMID: 22957638
% 
%  Started from Avinash Uppupuri's code on Matlab file exchange. It has then been vectorized. Three
%  features were not implemented correctly in that code, it has since then been changed. The features
%  are:
%    * Sum of squares: variance
%    * Difference variance
%    * Sum Variance
% 
%  Note: ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
%