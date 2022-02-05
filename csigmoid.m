function y = csigmoid(x,A,B)

y = 1./(1+exp(x*A+B));
