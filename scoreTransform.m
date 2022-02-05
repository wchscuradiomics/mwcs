function S = scoreTransform(S)

if sum(S(:)>1)>0 || sum(S(:)<0)>0
  for i=1:size(S,1)
    S(i,:)= softmax(S(i,:)')';
  end
end