function MAXS = maxabs2(COEFFS)
%MAXS = maxabs(COEFFS) reorganize coefficient matrices.
%
% COEFFS is an 1 * g cell, of which an element is a n * c cell. g is the number of groups. n is the
% number of samples. c is the number of components in a group for each sample.

[~,g] = size(COEFFS);
[n,c] = size(COEFFS{1});

MAXS = cell(n,g); % n samples; g groups; c components in a group
for i=1:n % for each sample
  for j=1:g
    % CMS = cmat2cell( merge( COEFFS{j}(i,:) ) );
    MAXS{i,j} =  merge( COEFFS{j}(i,:) ) ;
  end
end

end

function M = merge(CS)
%M = merge(CS) reorganize coefficient matrices.
%
% CS is an 1 * c cell.

for x = 2:size(CS,2)
  if size(CS{1},1) ~= size(CS{x},1) || size(CS{1},2) ~= size(CS{x},2)
    error('The sizes of all coefficient matrices must be the same.');
  end
end

[m,n] = size(CS{1});
M = zeros(m,n,size(CS,2));
for i=1:m
  for j=1:n
    v = zeros(1,size(CS,2));
    for x=1:size(CS,2)
      v(x) = CS{x}(i,j);
      % if isnan(v(k))
      %  error('Nan value is invalid.');
      % end
      if isnan(v(x))
        v(x) = 0;
      end
    end
    
    v = maxabsolution(v);
    % if length(v) ~= size(CS,2), error('...');
    for x=1:size(CS,2)
      M(i,j,x) = v(x);
    end
  end
end

M = M(:,:,1);
end

function maxi = maxabsolution(v)
a = abs(v);
[~,idx] = sort(a,'descend');
maxi = v(idx);
end

function C= cmat2cell(A)
  C = cell(1,size(A,3));
  for j=1:size(C,2)
    C{j} = A(:,:,j);
  end
end

