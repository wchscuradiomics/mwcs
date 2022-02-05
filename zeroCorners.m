function indices = zeroCorners(M)

[nRows,nCols]=size(M);
indices = zeros(nRows*nCols,1);
limit = 1e-4;
k = 0;
for i=1:nRows
  for j=1:nCols
    if abs(M(i,j)) <=limit
      k = k + 1;
      indices(k) = sub2ind([nRows nCols],i,j);
    else
      break;
    end
  end
end

for i=nRows:-1:1
  for j=nCols:-1:1
    if abs(M(i,j)) <=limit
      k = k + 1;
      indices(k) = sub2ind([nRows nCols],i,j);
    else
      break;
    end
  end
end

indices = indices(1:k);