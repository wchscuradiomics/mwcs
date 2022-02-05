# MWCS toolbox
A feature extraction technique (called Maximum wavelet-coefficient statistics, MWCS) to highlight the differences of histopathological characteristics by reorganizing and expressing the patterns of wavelet-coefficients that represent local changes.

Note: Please start with experiment.m.

1. Referenced tools:
1). Giorgio (2021). Feature Selection Library (https://www.mathworks.com/matlabcentral/fileexchange/56937-feature-selection-library), MATLAB Central File Exchange. Retrieved November 5, 2021.

2). Gabriele Lombardi (2021). Parzen PNN (https://www.mathworks.com/matlabcentral/fileexchange/11880-parzen-pnn), MATLAB Central File Exchange. Retrieved November 5, 2021.

3). Minh Do (2021). Contourlet toolbox (https://www.mathworks.com/matlabcentral/fileexchange/8837-contourlet-toolbox), MATLAB Central File Exchange. Retrieved November 5, 2021.
% Modified to obtain low-frequency components at each decomposition level

4). X. Sun, W. Xu, Fast implementation of DeLong's algorithm for comparing the areas under correlated receiver operating characteristic curves, IEEE Signal Processing Letters 21 (11) (2014) 1389-1393. https://github.com/PamixSun/DeLongUI

5). Xunkai Wei (2021). Gray Level Run Length Matrix Toolbox (https://www.mathworks.com/matlabcentral/fileexchange/17482-gray-level-run-length-matrix-toolbox), MATLAB Central File Exchange. Retrieved November 5, 2021.
% Modified to make the codes can obtain GLRLM from ROIs with nan values.

2. Execute codes with experiment.m

3. Dataset in dataset.mat, Feature sets in feature.mat
