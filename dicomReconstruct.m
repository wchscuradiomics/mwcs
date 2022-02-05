function DCM2 = dicomReconstruct(DCM1,ps1,ps2,limits,integer,method)
%
% method: linear (default), nearest, cubic, makima, spline

if nargin  == 5
  method = 'linear';
end

[n1Rows,n1Cols] = size(DCM1);
% height = n1Rows * ps1(1);
% width = n1Cols * ps1(2);

% n2Rows =  height / ps2(1) ;
% n2Cols = width / ps2(2);

[x,y] = meshgrid(1:n1Cols,1:n1Rows);
dRows = (n1Rows-1)/(n1Rows*ps1(1)/ps2(1) - 1);
dCols = (n1Cols-1)/(n1Cols*ps1(2)/ps2(2) - 1);
[xq,yq] = meshgrid(1:dCols:n1Cols,1:dRows:n1Rows);

% DCM2 = round(imresize(DCM1, [n2Rows n2Cols], method));
DCM2 = interp2(x,y,double(DCM1), xq,yq, method);

if integer
  DCM2 = round(DCM2);
end

if ~isempty(limits)
  DCM2(DCM2<limits(1)) = limits(1);
  DCM2(DCM2>limits(2)) = limits(2);
end