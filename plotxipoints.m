function plotxipoints(v,u,sigma,b,ks,npoints,limits,hi,textx,xname)

width = limits(2)-limits(1);

mini = (min(v) - u)*b/(sigma*ks);
maxi = (max(v) - u)*b/(sigma*ks);
s = sort([mini maxi]);
mini =s(1);maxi=s(2);
if mini > limits(1)
  limits(1) = mini;
end

if maxi < limits(2)
  limits(2) = maxi;
end

if (limits(2)-limits(1))/width < 0.4
  npoints = npoints - 4;
end

xpoints = limits(1):(limits(2)-limits(1))/npoints:limits(2);
x = xpoints*sigma*ks/b + u;

plot(xpoints,hi*ones(1,length(x)),'k','LineWidth',0.5)
drawScale(xpoints,hi,x);

text(textx,hi,xname);


