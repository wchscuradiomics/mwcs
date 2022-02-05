function [h,mini,maxi] = countHu(C)

n = size(C,1);
minis = ones(n,1)*Inf; 
maxis = -ones(n,1)*Inf;

for i=1:n
  a = min(C{i}(:));
  b = max(C{i}(:));
  if a < minis(i)
    minis(i) = a;
  end
  
  if b > maxis(i)
    maxis(i) = b;
  end
end

mini = min(minis);
maxi = max(maxis);

m = maxi - mini + 1;

h = zeros(1,m);

for k=1:m
  for i=1:n
    h(k) = sum(C{i} == mini+k-1 ,'all') + h(k);
  end
end