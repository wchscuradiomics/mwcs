function checkNanCoefficients(COEFFS,waveletName)

for i=1:size(COEFFS,1)
  for j=1:size(COEFFS,2)
    n = sum(~isnan(COEFFS{i,j}),'all');
    if  n < 9
      error(['wavelet name = ' waveletName '; i=' num2str(i) ', j=' num2str(j) ' 的非NAN个数<10，仅有' num2str(n) '个.']);
    end
  end
end