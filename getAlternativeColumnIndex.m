function alternativeColumnIndex = getAlternativeColumnIndex(nCols2Result,targetColumnIndex)
%alternativeColumnIndex = getAlternativeColumnIndex(nCols2Result,targetColumnIndex) 

if targetColumnIndex == nCols2Result-1 % target column is for training
  alternativeColumnIndex = nCols2Result;
elseif targetColumnIndex == nCols2Result
  alternativeColumnIndex = nCols2Result - 1;
else
  error('The value of targetColumnIndex is invalid.');
end