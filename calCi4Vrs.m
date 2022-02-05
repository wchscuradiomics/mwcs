function [m,s,ci] = calCi4Vrs(vrs)

vals = zeros(length(vrs),1);
for i=1:length(vrs)
  vals(i) = vrs{i}.auc;
end

m = mean(vals);
s = std(vals);

ci = calci(m,s,length(vrs));