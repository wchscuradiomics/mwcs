% Properties of gray-level co-occurrence matrix.
%    STATS = GRAYCOPROPS(GLCM,PROPERTIES) normalizes the gray-level
%    co-occurrence matrix (GLCM) so that the sum of its elements is one. Each
%    element in the normalized GLCM, (r,c), is the joint probability occurrence
%    of pixel pairs with a defined spatial relationship having gray level
%    values r and c in the image. GRAYCOPROPS uses the normalized GLCM to
%    calculate PROPERTIES.
% 
%    GLCM can be an m x n x p array of valid gray-level co-occurrence
%    matrices. Each gray-level co-occurrence matrix is normalized so that its
%    sum is one.
% 
%    PROPERTIES can be a comma-separated list of strings, a cell array
%    containing strings, the string 'all', or a space separated string. They
%    can be abbreviated, and case does not matter.
% 
%    Properties include:
% 
%    'Contrast'      the intensity contrast between a pixel and its neighbor
%                    over the whole image. Range = [0 (size(GLCM,1)-1)^2].
%                    Contrast is 0 for a constant image.
% 
%    'Correlation'   statistical measure of how correlated a pixel is to its
%                    neighbor over the whole image. Range = [-1 1].
%                    Correlation is 1 or -1 for a perfectly positively or
%                    negatively correlated image. Correlation is NaN for a
%                    constant image.
% 
%    'Energy'        summation of squared elements in the GLCM. Range = [0 1].
%                    Energy is 1 for a constant image.
% 
%    'Homogeneity'   closeness of the distribution of elements in the GLCM to
%                    the GLCM diagonal. Range = [0 1]. Homogeneity is 1 for
%                    a diagonal GLCM.
%    'Entropy'
% 
% 
%    If PROPERTIES is the string 'all', then all of the above properties are
%    calculated. This is the default behavior. Please refer to the
%    Documentation for more information on these properties.
% 
%    STATS is a structure with fields that are specified by PROPERTIES. Each
%    field contains a 1 x p array, where p is the number of gray-level
%    co-occurrence matrices in GLCM. For example, if GLCM is an 8 x 8 x 3 array
%    and PROPERTIES is 'Energy', then STATS is a structure containing the
%    field 'Energy'. This field contains a 1 x 3 array.
% 
%    Notes
%    -----
%    Energy is also known as uniformity, uniformity of energy, and angular second
%    moment.
% 
%    Contrast is also known as variance and inertia.
% 
%    Class Support
%    -------------
%    GLCM can be logical or numeric, and it must contain real, non-negative, finite,
%    integers. STATS is a structure.
% 
%    Examples
%    --------
%    GLCM = [0 1 2 3;1 1 2 3;1 0 2 0;0 0 0 3];
%    stats = graycoprops(GLCM)
% 
%    I = imread('circuit.tif');
%    GLCM2 = graycomatrix(I,'Offset',[2 0;0 2]);
%    stats = graycoprops(GLCM2,{'contrast','homogeneity'})
% 
%    See also GRAYCOMATRIX.
%