function DBS= createDistributionNames(n,dimension)

  DBS = cell(n,dimension); % Kernel Normal
  DBS(1,:) = repmat({'Kernel'},1,dimension);
  DBS(2,:) = repmat({'Normal'},1,dimension);
  for i=3:n
    rng('shuffle');
    p = rand(1,dimension);
    DBS(i,p>=0.5) = {'Kernel'};
    DBS(i,p<0.5) = {'Normal'};
  end
end